#!/bin/bash
set -e

# Compile main.ts into build/main.js and dependencies
npx tsc

# Combine build/editor/main.js and dependencies into website/modern-monastery.js
npx rollup build/editor/main.js \
	--file website/modern-monastery.js \
	--format iife \
	--output.name modern-monastery \
	--context exports \
	--sourcemap \
	--plugin rollup-plugin-sourcemaps \
	--plugin @rollup/plugin-node-resolve

# Minify website/modern-monastery.js into website/modern-monastery.min.js
npx terser \
	website/modern-monastery.js \
	--source-map "content='website/modern-monastery.js.map',url=modern-monastery.min.js.map" \
	-o website/modern-monastery.min.js \
	--compress \
	--define OFFLINE=false \
	--mangle \
	--mangle-props regex="/^_.+/;"
	

