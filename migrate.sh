#!/bin/bash

echo -n "Rename project to what? "
read PROJECT_NAME

# remove previously migrated directories
rm -fr Libraries Tests Application Application.xcodeproj
rm -fr $PROJECT_NAME $PROJECT_NAME.xcodeproj

rm -rf /tmp/iOSXcodeStarterProject
git clone git@github.com:twobitlabs/iOSXcodeStarterProject.git /tmp/iOSXcodeStarterProject

cp -fr /tmp/iOSXcodeStarterProject/Tests /tmp/iOSXcodeStarterProject/Application /tmp/iOSXcodeStarterProject/Application.xcodeproj /tmp/iOSXcodeStarterProject/.gitignore /tmp/iOSXcodeStarterProject/Vendorfile .

sed -i "" s/Application.app\\/Application/$PROJECT_NAME.app\\/$PROJECT_NAME/g Application.xcodeproj/project.pbxproj
sed -i "" "s/path = Application/path = $PROJECT_NAME/g" Application.xcodeproj/project.pbxproj
sed -i "" s/Application.app/$PROJECT_NAME.app/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application\\/Application-Info.plist/$PROJECT_NAME\\/$PROJECT_NAME-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application\\/Application-Prefix.pch/$PROJECT_NAME\\/$PROJECT_NAME-Prefix.pch/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Info.plist/$PROJECT_NAME-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Dev-Info.plist/$PROJECT_NAME-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Debug-Info.plist/$PROJECT_NAME-Info.plist/g Application.xcodeproj/project.pbxproj
sed -i "" s/Application-Prefix.pch/$PROJECT_NAME-Prefix.pch/g Application.xcodeproj/project.pbxproj
sed -i "" "s/= Application/= $PROJECT_NAME/g" Application.xcodeproj/project.pbxproj
sed -i "" s/Application/$PROJECT_NAME/g Vendorfile

mv -f Application $PROJECT_NAME
mv $PROJECT_NAME/Application-Info.plist $PROJECT_NAME/$PROJECT_NAME-Info.plist
mv $PROJECT_NAME/Application-Dev-Info.plist $PROJECT_NAME/$PROJECT_NAME-Dev-Info.plist
mv $PROJECT_NAME/Application-Debug-Info.plist $PROJECT_NAME/$PROJECT_NAME-Debug-Info.plist
mv $PROJECT_NAME/Application-Prefix.pch $PROJECT_NAME/$PROJECT_NAME-Prefix.pch
mv -f Application.xcodeproj $PROJECT_NAME.xcodeproj


