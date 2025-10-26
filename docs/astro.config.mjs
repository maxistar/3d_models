// @ts-check
import { defineConfig } from 'astro/config';

import react from '@astrojs/react';

const repoName = '/3d_models';

// https://astro.build/config
export default defineConfig({
  site: `https://projects.maxistar.me${repoName}/`,
  base: '/3d_models',
  integrations: [react()]
});
