#!/bin/bash -e

if [[ "${BASH_SOURCE[0]}" == "" || "${BASH_SOURCE[0]}" == "/dev"* ]] ; then
	RUNNING_LOCALLY=false
	TMPDIR=`mktemp -d /tmp/ios-starter.XXXXXX`	
else
	RUNNING_LOCALLY=true
	TMPDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

echo
echo -n "Application Name (e.g. 'MyApplication' with no spaces will be created in current dir)? "
read PROJECT_NAME
mkdir "$PROJECT_NAME"

if ! $RUNNING_LOCALLY ; then
	git clone git@github.com:twobitlabs/iOSXcodeStarterProject.git $TMPDIR
fi
cd "$PROJECT_NAME"

cp -fr $TMPDIR/Tests \
$TMPDIR/Classes \
$TMPDIR/Application.xcodeproj \
$TMPDIR/.gitignore \
$TMPDIR/Libraries \
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

mv -f Application.xcodeproj "$PROJECT_NAME.xcodeproj"
cd "$PROJECT_NAME.xcodeproj"
rm -rf xcuserdata
rm -rf project.xcworkspace/xcuserdata
cd ..


cd Classes
mv Application-Info.plist $PROJECT_NAME-Info.plist
mv Application-Dev-Info.plist $PROJECT_NAME-Dev-Info.plist
mv Application-Debug-Info.plist $PROJECT_NAME-Debug-Info.plist
mv Application-Prefix.pch $PROJECT_NAME-Prefix.pch
cd ..

# Remove all empty library directories (which contain the placeholders for submodules)
cd Libraries
find . -type d -empty -exec rmdir {} \;
cd ..

git init .
git submodule add git://github.com/twobitlabs/TBMacros.git Libraries/TBMacros
git submodule add git://github.com/twobitlabs/AnalyticsKit.git Libraries/AnalyticsKit
git submodule add git://github.com/twobitlabs/MagicalRecord.git Libraries/MagicalRecord
git submodule add git://github.com/twobitlabs/ocmock.git Libraries/OCMock
git submodule add git://github.com/twobitlabs/TestFlight-SDK.git Libraries/TestFlightSDK
git add .
git commit -a -m "Initial Commit"

if ! $RUNNING_LOCALLY ; then
	rm -rf $TMPDIR
fi

echo "Success! Launching $PROJECT_NAME"
open $PROJECT_NAME.xcodeproj

