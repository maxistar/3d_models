# Astro Starter Kit: Basics


## Prepare local model assets

Run from the `docs` directory. OpenSCAD assets can be linked as before, but
build123d should expose only generated STL files; linking the whole project also
publishes its Python environment and can make Astro's static build fail.

```sh
ln -s ../../openscad public/openscad
rm -rf public/build123d
mkdir -p public/build123d/simple public/build123d/phones
cp ../build123d/simple/*.stl public/build123d/simple/
cp ../build123d/phones/*.stl public/build123d/phones/
```

Repeat the copy step after regenerating build123d STL files.

## 🧞 Commands

All commands are run from the root of the project, from a terminal:

| Command                   | Action                                           |
| :------------------------ | :----------------------------------------------- |
| `npm install`             | Installs dependencies                            |
| `npm run dev`             | Starts local dev server at `localhost:4321`      |
| `npm run build`           | Build your production site to `./dist/`          |
| `npm run preview`         | Preview your build locally, before deploying     |
| `npm run astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `npm run astro -- --help` | Get help using the Astro CLI                     |


