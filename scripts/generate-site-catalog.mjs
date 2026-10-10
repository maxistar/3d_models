#!/usr/bin/env node

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDirectory = path.dirname(fileURLToPath(import.meta.url));
const defaultRepoRoot = path.resolve(scriptDirectory, '..');

const toPosix = (value) => value.split(path.sep).join('/');

function readIgnoreEntries(ignorePath) {
  if (!fs.existsSync(ignorePath)) {
    return [];
  }

  return fs.readFileSync(ignorePath, 'utf8')
    .split(/\r?\n/)
    .map((line) => line.trim())
    .filter((line) => line && !line.startsWith('#'));
}

function isIgnored(relativePath, ignoredPaths) {
  return ignoredPaths.some((ignoredPath) => (
    relativePath === ignoredPath || relativePath.startsWith(`${ignoredPath}/`)
  ));
}

function listScadFiles(directory) {
  const files = [];
  const entries = fs.readdirSync(directory, { withFileTypes: true })
    .sort((left, right) => left.name.localeCompare(right.name));

  for (const entry of entries) {
    const entryPath = path.join(directory, entry.name);
    if (entry.isDirectory()) {
      files.push(...listScadFiles(entryPath));
    } else if (entry.isFile() && entry.name.toLowerCase().endsWith('.scad')) {
      files.push(entryPath);
    }
  }

  return files;
}

function humanize(value) {
  return value
    .split('_')
    .filter(Boolean)
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join(' ');
}

function slugify(value) {
  const slug = value
    .normalize('NFKD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/[^a-zA-Z0-9_-]+/g, '-')
    .replace(/_/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '')
    .toLowerCase();

  return slug || 'model';
}

function routeSegmentsForDirectory(directory) {
  return directory === '.' ? [] : directory.split('/').map(slugify);
}

function routePathForSegments(basePath, segments) {
  const suffix = segments.join('/');
  return suffix ? `${basePath}/${suffix}/` : `${basePath}/`;
}

function firstPrefix(stem) {
  return stem.split('_')[0] || stem;
}

function groupDirectoryItems(items, directory) {
  if (directory === 'honeycomb') {
    return [{ name: 'honeycomb', items }];
  }

  const buckets = new Map();
  for (const item of items) {
    const prefix = firstPrefix(item.stem);
    const bucket = buckets.get(prefix) ?? [];
    bucket.push(item);
    buckets.set(prefix, bucket);
  }

  return [...buckets.entries()]
    .map(([prefix, bucket]) => {
      const names = new Set(bucket.map((item) => item.stem));
      const coveringRoots = [...names]
        .filter((root) => bucket.every((item) => (
          item.stem === root || item.stem.startsWith(`${root}_`)
        )))
        .sort((left, right) => right.length - left.length);

      return {
        name: coveringRoots[0] ?? prefix,
        items: bucket,
      };
    })
    .sort((left, right) => left.name.localeCompare(right.name));
}

function buildLegacyRoutes(groups) {
  const definitions = {
    blocknote: (group) => group.directory === 'blocknote',
    helpinghand: (group) => (
      group.directory === 'helpinghand' && group.name === 'helping_hand'
    ),
    helpinghand_solid: (group) => group.directory === 'helpinghand_solid',
    cablewinder: (group) => group.directory === 'cable_organizer',
    honeycomb: (group) => group.directory === 'honeycomb',
  };

  return Object.fromEntries(
    Object.entries(definitions).map(([route, matches]) => [
      route,
      groups.filter(matches).map((group) => group.id),
    ]),
  );
}

export function buildCatalog({
  repoRoot = defaultRepoRoot,
  sourceRoot = path.join(repoRoot, 'openscad'),
  ignorePath = path.join(repoRoot, '.modelignore'),
  assetBase = '/3d_models/openscad',
} = {}) {
  if (!fs.existsSync(sourceRoot)) {
    throw new Error(`OpenSCAD source directory does not exist: ${sourceRoot}`);
  }

  const ignoredPaths = readIgnoreEntries(ignorePath);
  const excluded = [];
  const missingOutputs = [];
  const candidates = [];

  for (const scadPath of listScadFiles(sourceRoot)) {
    const name = path.basename(scadPath);
    const sourceRelative = toPosix(path.relative(sourceRoot, scadPath));
    const repositoryRelative = toPosix(path.relative(repoRoot, scadPath));

    if (name.startsWith('_')) {
      excluded.push({ path: repositoryRelative, reason: 'internal source' });
      continue;
    }

    if (isIgnored(repositoryRelative, ignoredPaths)) {
      excluded.push({ path: repositoryRelative, reason: '.modelignore' });
      continue;
    }

    const stlPath = scadPath.replace(/\.scad$/i, '.stl');
    if (!fs.existsSync(stlPath)) {
      missingOutputs.push({ path: repositoryRelative, reason: 'missing same-name STL' });
      continue;
    }

    candidates.push({
      directory: toPosix(path.relative(sourceRoot, path.dirname(scadPath))) || '.',
      stem: path.basename(scadPath, path.extname(scadPath)),
      sourcePath: sourceRelative,
      stlPath: toPosix(path.relative(sourceRoot, stlPath)),
      title: humanize(path.basename(scadPath, path.extname(scadPath))),
      assetUrl: `${assetBase}/${toPosix(path.relative(sourceRoot, stlPath))}`,
    });
  }

  const byDirectory = new Map();
  for (const item of candidates) {
    const directoryItems = byDirectory.get(item.directory) ?? [];
    directoryItems.push(item);
    byDirectory.set(item.directory, directoryItems);
  }

  const groups = [];
  for (const [directory, items] of [...byDirectory.entries()].sort()) {
    const directorySegments = routeSegmentsForDirectory(directory);
    const directoryRoutePath = routePathForSegments(assetBase, directorySegments);

    for (const family of groupDirectoryItems(
      items.sort((left, right) => left.sourcePath.localeCompare(right.sourcePath)),
      directory,
    )) {
      const slug = slugify(family.name);
      const id = directory === '.' ? slug : `${directory}/${slug}`;
      groups.push({
        id,
        slug,
        name: family.name,
        title: humanize(family.name),
        directory,
        directorySegments,
        directoryRoutePath,
        routePath: `${directoryRoutePath}${slug}/`,
        flatRoutePath: `${assetBase}/${slug}/`,
        items: [...family.items]
          .sort((left, right) => {
            if (left.stem === family.name) return -1;
            if (right.stem === family.name) return 1;
            return left.sourcePath.localeCompare(right.sourcePath);
          })
          .map(({ stem, sourcePath, stlPath, title, assetUrl }) => ({
          slug: slugify(stem),
          stem,
          title,
          sourcePath,
          stlPath,
          assetUrl,
          })),
      });
    }
  }

  const slugOwners = new Map();
  for (const group of groups) {
    const ownerKey = `${group.directory}/${group.slug}`;
    const owner = slugOwners.get(ownerKey);
    if (owner) {
      throw new Error(
        `Model group slug collision: "${group.slug}" in directory `
        + `"${group.directory}" is used by `
        + `${owner.directory}/${owner.name} and ${group.directory}/${group.name}`,
      );
    }
    slugOwners.set(ownerKey, group);
  }

  groups.sort((left, right) => left.routePath.localeCompare(right.routePath));

  const directories = [...byDirectory.keys()]
    .sort((left, right) => left.localeCompare(right))
    .map((directory) => {
      const routeSegments = routeSegmentsForDirectory(directory);
      const directoryGroups = groups.filter((group) => group.directory === directory);
      return {
        path: directory,
        name: directory === '.' ? 'root' : directory.split('/').at(-1),
        title: directory === '.' ? 'root' : directory,
        routeSegments,
        routePath: routePathForSegments(assetBase, routeSegments),
        groupIds: directoryGroups.map((group) => group.id),
      };
    });

  const directoryRoutePaths = new Set(
    directories
      .filter((directory) => directory.path !== '.')
      .map((directory) => directory.routePath),
  );
  const flatRouteOwners = new Map();
  for (const group of groups) {
    const owners = flatRouteOwners.get(group.flatRoutePath) ?? [];
    owners.push(group);
    flatRouteOwners.set(group.flatRoutePath, owners);
  }
  for (const group of groups) {
    group.flatRouteAvailable = (
      flatRouteOwners.get(group.flatRoutePath).length === 1
      && !directoryRoutePaths.has(group.flatRoutePath)
    );
  }

  const routeOwners = new Map();
  const registerRoute = (routePath, owner) => {
    const existing = routeOwners.get(routePath);
    if (existing) {
      throw new Error(
        `Public route collision: "${routePath}" is used by `
        + `${existing} and ${owner}`,
      );
    }
    routeOwners.set(routePath, owner);
  };

  for (const directory of directories) {
    if (directory.path !== '.') {
      registerRoute(directory.routePath, `directory ${directory.path}`);
    }
  }
  for (const group of groups) {
    registerRoute(group.routePath, `group ${group.id}`);
    if (group.flatRouteAvailable && group.flatRoutePath !== group.routePath) {
      registerRoute(group.flatRoutePath, `flat compatibility route for ${group.id}`);
    }
  }

  return {
    version: 1,
    groups,
    directories,
    legacyRoutes: buildLegacyRoutes(groups),
    diagnostics: {
      sourceCount: candidates.length + excluded.length + missingOutputs.length,
      includedSourceCount: candidates.length,
      excluded,
      missingOutputs,
    },
  };
}

export function renderCatalogModule(catalog) {
  return [
    '// This file is generated by scripts/generate-site-catalog.mjs. Do not edit.',
    `export const modelCatalog = ${JSON.stringify(catalog, null, 2)};`,
    'export default modelCatalog;',
    '',
  ].join('\n');
}

export function writeCatalog(catalog, outputPath) {
  fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  fs.writeFileSync(outputPath, renderCatalogModule(catalog));
}

function printDiagnostics(catalog) {
  const { diagnostics } = catalog;
  const itemCount = catalog.groups.reduce((total, group) => total + group.items.length, 0);

  console.log(`Catalog: ${catalog.groups.length} groups, ${itemCount} model items`);
  console.log(`Directories: ${catalog.directories.length}`);
  console.log(`Included sources: ${diagnostics.includedSourceCount}`);
  console.log(`Excluded sources: ${diagnostics.excluded.length}`);
  console.log(`Missing STL outputs: ${diagnostics.missingOutputs.length}`);

  for (const entry of diagnostics.excluded) {
    console.log(`  ↷ ${entry.path} (${entry.reason})`);
  }
  for (const entry of diagnostics.missingOutputs) {
    console.log(`  ! ${entry.path} (${entry.reason})`);
  }

  console.log('Groups:');
  for (const group of catalog.groups) {
    console.log(`  • ${group.routePath}: ${group.items.length} item(s)`);
  }
}

export function main() {
  const catalog = buildCatalog();
  const outputPath = path.join(
    defaultRepoRoot,
    'docs',
    'src',
    'generated',
    'model-catalog.ts',
  );

  writeCatalog(catalog, outputPath);
  printDiagnostics(catalog);
  console.log(`Wrote ${toPosix(path.relative(defaultRepoRoot, outputPath))}`);
}

const isMain = process.argv[1]
  && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url);

if (isMain) {
  main();
}
