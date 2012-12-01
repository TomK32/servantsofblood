#!/bin/bash

VERSION=0.8.0
BUILD="`pwd`/build"
mkdir -p ${BUILD}

for ARCH in "win-x86" "win-x64" "macosx-ub"
do
  if [ ! -f "$BUILD/love-${VERSION}-${ARCH}.zip" ];
  then
    wget "https://bitbucket.org/rude/love/downloads/love-${VERSION}-${ARCH}.zip" -P "${BUILD}"
  fi
done


# https://github.com/josefnpat/LD24/blob/master/build.sh
#Configure this, and also ensure you have the build/osx.patch ready.
NAME="Cross Country Runner"

GAME_VERSION=`git tag|tail -1`
REVISION=`git log ${GAME_VERSION}..HEAD --pretty=format:'' | wc -l | sed -e 's/ //g'`

FILENAME="$NAME-$GAME_VERSION-$REVISION"
git archive HEAD -o "$BUILD/$FILENAME.zip"

echo "game = {}; game.version = '${GAME_VERSION}-${REVISION}'" > "version.lua"
zip -q "$BUILD/$FILENAME.zip" "version.lua"
mv "$BUILD/$FILENAME.zip" "$BUILD/$FILENAME.love"

GAME="$BUILD/$FILENAME.love"

echo "Building $FILENAME"

for arch in 'win-x86' 'win-x64'
do
  A="$BUILD/love-$VERSION-$arch"
  if [ -f "$BUILD/$A" ]; then rm "$BUILD/$A"; fi
  unzip -q -d "$BUILD" "$A.zip"
  cat "$GAME" >> "$A/love.exe"

  mv "$A" "$BUILD/${FILENAME}_$arch"
  R_PWD=`pwd`
  cd "$BUILD/${FILENAME}_$arch"

  echo "$BUILD/${FILENAME}_$arch.zip"
  if [ -f "$BUILD/${FILENAME}_$arch.zip" ]; then rm "$BUILD/${FILENAME}_$arch.zip"; fi
  zip -q -r "$BUILD/${FILENAME}_$arch.zip" .
  rm -R "$BUILD/${FILENAME}_$arch"
  cd "$R_PWD"
done

# OS X
echo "$BUILD/${FILENAME}.app.zip"
if [ -d  "$BUILD/love.app" ]; then rm -R "$BUILD/love.app"; fi
unzip -q -d "$BUILD" "$BUILD/love-$VERSION-macosx-ub.zip"
mv "$BUILD/love.app" "$BUILD/${FILENAME}.app"
cp "$BUILD/$FILENAME.love" "$BUILD/$FILENAME.app/Contents/Resources/"
patch "$BUILD/${FILENAME}.app/Contents/Info.plist" -i "$BUILD/osx.patch"
R_PWD=`pwd`
cd "$BUILD"
if [ -f "${FILENAME}_macosx.zip" ]; then rm "${FILENAME}_macosx.zip"; fi
zip -q -r "${FILENAME}_macosx.zip" "${FILENAME}.app"
cd $R_PWD
rm -rf "$BUILD/$FILENAME.app"
# Cleanup
