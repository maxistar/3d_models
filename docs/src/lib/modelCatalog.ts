import modelCatalog from '../generated/model-catalog';

export function groupsForLegacyRoute(route: string) {
  const slugs = modelCatalog.legacyRoutes[route] ?? [];
  return modelCatalog.groups.filter((group) => slugs.includes(group.slug));
}

export { modelCatalog };
