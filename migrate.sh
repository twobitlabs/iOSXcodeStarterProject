#!/bin/bash

echo -n "Rename project to what? "
read PROJECT_NAME

# remove previously migrated directories
rm -fr Libraries Tests Classes Application.xcodeproj
rm -fr $PROJECT_NAME $PROJECT_NAME.xcodeproj

rm -rf /tmp/iOSXcodeStarterProject
git clone git@github.com:twobitlabs/iOSXcodeStarterProject.git /tmp/iOSXcodeStarterProject

cp -fr /tmp/iOSXcodeStarterProject/Tests /tmp/iOSXcodeStarterProject/Classes /tmp/iOSXcodeStarterProject/Application.xcodeproj /tmp/iOSXcodeStarterProject/.gitignore /tmp/iOSXcodeStarterProject/Vendorfile /tmp/iOSXcodeStarterProject/Libraries .

sed -i "" s/Application.app\\/Application/$PROJECT_NAME.app\\/$PROJECT_NAME/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application.app/$PROJECT_NAME.app/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Info.plist/$PROJECT_NAME-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Prefix.pch/$PROJECT_NAME-Prefix.pch/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Info.plist/$PROJECT_NAME-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Dev-Info.plist/$PROJECT_NAME-Dev-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Debug-Info.plist/$PROJECT_NAME-Debug-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Prefix.pch/$PROJECT_NAME-Prefix.pch/g Application.xcodeproj/project.pbxproj
sed -i "" "s/= Application/= $PROJECT_NAME/g" Application.xcodeproj/project.pbxproj
sed -i "" s/Application/$PROJECT_NAME/g Vendorfile

mv -f Application.xcodeproj $PROJECT_NAME.xcodeproj

cd Classes
mv Application-Info.plist $PROJECT_NAME-Info.plist
mv Application-Dev-Info.plist $PROJECT_NAME-Dev-Info.plist
mv Application-Debug-Info.plist $PROJECT_NAME-Debug-Info.plist
mv Application-Prefix.pch $PROJECT_NAME-Prefix.pch

cd ..

vendor install

echo "Success! Launching $PROJECT_NAME"
open $PROJECT_NAME.xcodeproj

