import modelCatalog from '../generated/model-catalog';

export function groupsForLegacyRoute(route: string) {
  const ids = modelCatalog.legacyRoutes[route] ?? [];
  return modelCatalog.groups.filter((group) => ids.includes(group.id));
}

export function groupsForDirectory(directoryPath: string) {
  const directory = modelCatalog.directories.find(
    (entry) => entry.path === directoryPath,
  );
  if (!directory) {
    return [];
  }

  return directory.groupIds
    .map((id) => modelCatalog.groups.find((group) => group.id === id))
    .filter(Boolean);
}

export function canonicalPathForLegacyRoute(route: string) {
  const groups = groupsForLegacyRoute(route);
  const groupPaths = [...new Set(groups.map((group) => group.routePath))];
  if (groupPaths.length === 1) {
    return groupPaths[0];
  }

  const directoryPaths = [...new Set(groups.map((group) => group.directoryRoutePath))];
  return directoryPaths.length === 1 ? directoryPaths[0] : undefined;
}

export { modelCatalog };
