#!/bin/bash -e
echo
echo -n "Application Name (e.g. 'MyApplication' with no spaces)? "
read PROJECT_NAME
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME"

TMPDIR=`mktemp -d /tmp/ios-starter.XXXXXX`
git clone git@github.com:twobitlabs/iOSXcodeStarterProject.git /tmp/$TMPDIR

cp -fr /tmp/$TMPDIR/Tests \
/tmp/$TMPDIR/Classes \
/tmp/$TMPDIR/Application.xcodeproj \
/tmp/$TMPDIR/.gitignore \
/tmp/$TMPDIR/Libraries \
.

sed -i "" s/Application.app\\/Application/$PROJECT_NAME.app\\/$PROJECT_NAME/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application.app/$PROJECT_NAME.app/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Info.plist/$PROJECT_NAME-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Prefix.pch/$PROJECT_NAME-Prefix.pch/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Info.plist/$PROJECT_NAME-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Dev-Info.plist/$PROJECT_NAME-Dev-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Debug-Info.plist/$PROJECT_NAME-Debug-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Prefix.pch/$PROJECT_NAME-Prefix.pch/g Application.xcodeproj/project.pbxproj
sed -i "" "s/= Application/= $PROJECT_NAME/g" Application.xcodeproj/project.pbxproj

mv -f Application.xcodeproj $PROJECT_NAME.xcodeproj

cd Classes
mv Application-Info.plist $PROJECT_NAME-Info.plist
mv Application-Dev-Info.plist $PROJECT_NAME-Dev-Info.plist
mv Application-Debug-Info.plist $PROJECT_NAME-Debug-Info.plist
mv Application-Prefix.pch $PROJECT_NAME-Prefix.pch

rm -rf $TMPDIR

echo "Success! Launching $PROJECT_NAME"
open $PROJECT_NAME.xcodeproj

