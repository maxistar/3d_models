import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import test from 'node:test';

import { buildCatalog } from './generate-site-catalog.mjs';

function createFixture() {
  const repoRoot = fs.mkdtempSync(path.join(os.tmpdir(), 'model-catalog-'));
  const sourceRoot = path.join(repoRoot, 'openscad');
  fs.mkdirSync(sourceRoot, { recursive: true });

  const addModel = (relativePath, withStl = true) => {
    const sourcePath = path.join(sourceRoot, relativePath);
    fs.mkdirSync(path.dirname(sourcePath), { recursive: true });
    fs.writeFileSync(sourcePath, '// fixture');
    if (withStl) {
      fs.writeFileSync(sourcePath.replace(/\.scad$/, '.stl'), 'solid fixture');
    }
  };

  addModel('phones/mi9_pro.scad');
  addModel('phones/mi9_pro_case.scad');
  addModel('phones/single.scad');
  addModel('phones/xiaomi/nested.scad');
  addModel('phones/_library.scad');
  addModel('phones/ignored.scad');
  addModel('phones/missing.scad', false);
  addModel('honeycomb/panel_9x9.scad');
  addModel('honeycomb/perimeter_bottom.scad');
  addModel('root_model.scad');
  addModel('ignored-only/ignored.scad');
  addModel('internal-only/_helper.scad');
  fs.writeFileSync(path.join(sourceRoot, 'honeycomb', 'orphan.stl'), 'solid fixture');
  fs.writeFileSync(
    path.join(repoRoot, '.modelignore'),
    'openscad/phones/ignored.scad\nopenscad/ignored-only/ignored.scad\n',
  );

  return { repoRoot, sourceRoot };
}

test('buildCatalog applies source/output filtering and grouping rules', () => {
  const fixture = createFixture();
  const catalog = buildCatalog(fixture);

  const phones = catalog.groups.find((group) => group.slug === 'mi9-pro');
  assert.deepEqual(
    phones.items.map((item) => item.stem),
    ['mi9_pro', 'mi9_pro_case'],
  );
  assert.equal(catalog.groups.some((group) => group.slug === 'single'), true);
  assert.equal(catalog.groups.some((group) => group.slug === 'library'), false);
  assert.equal(catalog.groups.some((group) => group.slug === 'orphan'), false);
  assert.equal(catalog.groups.find((group) => group.slug === 'honeycomb').items.length, 2);
  assert.equal(catalog.groups.find((group) => group.slug === 'mi9-pro').directory, 'phones');
  assert.equal(
    catalog.groups.find((group) => group.slug === 'mi9-pro').routePath,
    '/3d_models/openscad/phones/mi9-pro/',
  );
  assert.equal(
    catalog.groups.find((group) => group.slug === 'nested').directory,
    'phones/xiaomi',
  );
  assert.equal(catalog.groups.find((group) => group.slug === 'root-model').directory, '.');
  assert.deepEqual(
    catalog.directories.map((directory) => directory.path),
    ['.', 'honeycomb', 'phones', 'phones/xiaomi'],
  );
  assert.equal(catalog.directories.some((directory) => directory.path === 'ignored-only'), false);
  assert.equal(catalog.directories.some((directory) => directory.path === 'internal-only'), false);
  assert.equal(
    catalog.diagnostics.excluded.some((entry) => entry.reason === 'internal source'),
    true,
  );
  assert.equal(
    catalog.diagnostics.excluded.some((entry) => entry.reason === '.modelignore'),
    true,
  );
  assert.deepEqual(
    catalog.diagnostics.missingOutputs.map((entry) => entry.path),
    ['openscad/phones/missing.scad'],
  );
});

test('buildCatalog rejects duplicate public slugs', () => {
  const fixture = createFixture();
  const addDuplicate = (directory) => {
    const sourcePath = path.join(fixture.sourceRoot, directory, 'foo_bar.scad');
    fs.mkdirSync(path.dirname(sourcePath), { recursive: true });
    fs.writeFileSync(sourcePath, '// fixture');
    fs.writeFileSync(sourcePath.replace(/\.scad$/, '.stl'), 'solid fixture');
    const duplicatePath = path.join(fixture.sourceRoot, directory, 'foo-bar.scad');
    fs.writeFileSync(duplicatePath, '// fixture');
    fs.writeFileSync(duplicatePath.replace(/\.scad$/, '.stl'), 'solid fixture');
  };
  addDuplicate('phones');

  assert.throws(
    () => buildCatalog(fixture),
    /Model group slug collision: "foo-bar" in directory "phones"/,
  );
});
