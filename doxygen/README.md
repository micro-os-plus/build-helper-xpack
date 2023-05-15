# Doxygen

The projects websites are generated with [Doxygen](https://www.doxygen.nl).

To build the site, run the following from the top project folder:

```sh
doxygen website/config.doxygen
```

The result is in `website/html`.

## Content

The input folders are:

- `src`
- `include`
- `website/pages`
- `README.md` <- the home page

## Theme

The project uses the custom <https://jothepro.github.io/doxygen-awesome-css/> theme.

Other projects using this theme (for inspiration):

- https://docs.wxwidgets.org/stable/
- https://jothepro.github.io/libCloudSync/

Customisations:

```sh
doxygen -w html header.html delete_me.html delete_me.css
rm delete_me.html delete_me.css
```

```text
HTML_HEADER            = xpacks/micro-os-plus-build-helper/doxygen/common-header.html

HTML_EXTRA_FILES       = \
xpacks/xpack-3rd-party-doxygen-awesome-css/doxygen-awesome-darkmode-toggle.js \
xpacks/xpack-3rd-party-doxygen-awesome-css/doxygen-awesome-fragment-copy-button.js \
xpacks/xpack-3rd-party-doxygen-awesome-css/doxygen-awesome-paragraph-link.js \
xpacks/xpack-3rd-party-doxygen-awesome-css/doxygen-awesome-interactive-toc.js \
xpacks/xpack-3rd-party-doxygen-awesome-css/doxygen-awesome-tabs.js

HTML_EXTRA_STYLESHEET  = \
xpacks/xpack-3rd-party-doxygen-awesome-css/doxygen-awesome.css \
xpacks/micro-os-plus-build-helper/doxygen/common-custom.css

HTML_COLORSTYLE        = LIGHT
HTML_COLORSTYLE_HUE    = 209
HTML_COLORSTYLE_SAT    = 255
HTML_COLORSTYLE_GAMMA  = 113
```

In `common-header.html` add the scripts.

```html
<head>
<!-- ... -->

<!-- Awesome Theme Begin -->
<script type="text/javascript" src="$relpath^doxygen-awesome-darkmode-toggle.js"></script>
<script type="text/javascript" src="$relpath^doxygen-awesome-fragment-copy-button.js"></script>
<script type="text/javascript" src="$relpath^doxygen-awesome-paragraph-link.js"></script>
<script type="text/javascript" src="$relpath^doxygen-awesome-interactive-toc.js"></script>
<script type="text/javascript" src="$relpath^doxygen-awesome-tabs.js"></script>

<script type="text/javascript">
DoxygenAwesomeDarkModeToggle.init()
DoxygenAwesomeFragmentCopyButton.init()
DoxygenAwesomeParagraphLink.init()
DoxygenAwesomeInteractiveToc.init()
DoxygenAwesomeTabs.init()
</script>
<!-- Awesome Theme End -->
</head>
```

## TODO

- nothing

## Legacy config

The previous µOS++ Reference also used:

```text
LAYOUT_FILE = DoxygenLayout.xml
```
