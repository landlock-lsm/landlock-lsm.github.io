# Landlock Website

This repository contains the source files for the [Landlock official website](https://landlock.io/).

## Development

This website is built using [Sphinx](https://www.sphinx-doc.org/) with [MyST Markdown](https://mystmd.org/):

```sh
mkdir website
./make-and-rsync.sh
uv run python -m http.server -b 127.0.0.1 -d website &
xdg-open http://127.0.0.1:8000
```

## Resources

- [Landlock logo](https://github.com/landlock-lsm/landlock-logo)

## License

All content is licensed under [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/).
