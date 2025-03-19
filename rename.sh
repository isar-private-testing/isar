#!/bin/bash

# Replace occurrences of 'package:isar/' with 'package:isar_community/' in Dart files
find . -name "*.dart" -type f -exec sed -i "s/'package:isar\//\'package:isar_community\//g" {} +
find . -name "*.dart" -type f -exec sed -i "s/'package:isar_generator\//\'package:isar_community_generator\//g" {} +
find . -name "*.dart" -type f -exec sed -i "s/'package:isar_generator\//\'package:isar_community_generator\//g" {} +

# Remove "hosted" lines and move *isar_version string in YAML and Markdown files
find . \( -name "*.yaml" -o -name "*.md" \) -type f -exec sed -i -E '/hosted:/d; s/^ {2}isar_version: &isar_version ([0-9]+\.[0-9]+\.[0-9]+) # define the version to be used$/  isar_generator: \*isar_version\n  isar:\n    version: \*isar_version\n  isar_flutter_libs:\n    version: \*isar_version/g' {} +

# Update the name in pubspec.yaml file
sed -i 's/^name: isar$/name: isar_community/g' ./packages/isar/pubspec.yaml


# Search YAML files and modify dependency versions for any 'isar' related entries
find . -name "*.yaml" -type f -exec sed -i -E '
/isar:\s*$/{
    N; # Append the next line (version line) to the pattern space
    s/(isar:)\s*\n\s*version: (.*)/\1 \2/; # Transform into a single line
}
' {} +



# Search YAML files and modify dependency versions for any 'isar' related entries
find . -name "*.yaml" -type f -exec sed -i -E '
/isar_generator:\s*$/{
    N; # Append the next line (version line) to the pattern space
    s/(isar_generator:)\s*\n\s*version: (.*)/\1 \2/; # Transform into a single line
}
' {} +

# Search YAML files and modify dependency versions for any 'isar' related entries
find . -name "*.yaml" -type f -exec sed -i -E '
/isar_flutter_libs:\s*$/{
    N; # Append the next line (version line) to the pattern space
    s/(isar_flutter_libs:)\s*\n\s*version: (.*)/\1 \2/; # Transform into a single line
}
' {} +


# Replace "https://isar-community.dev" with "https://isar-community.dev" in all files
find . -type f -exec sed -i 's#https://isar\.dev#https://isar-community.dev#g' {} +

# Update the name in pubspec.yaml file
sed -i 's/^name: isar$/name: isar_community/g' ./packages/isar_flutter_libs/pubspec.yaml
sed -i 's/^name: isar_generator$/name: isar_community_generator/g' ./packages/isar_generator/pubspec.yaml
sed -i 's/^name: isar_inspector$/name: isar_community_inspector/g' ./packages/isar_inspector/pubspec.yaml

# sed -i 's#^\(\s*\)isar: $/isar_community: /g' ./packages/isar_flutter_libs/pubspec.yaml
# sed -i 's#^\(\s*\)isar_generator: $/isar_community_generator: /g' ./packages/isar_generator/pubspec.yaml
# sed -i 's#^\(\s*\)isar_inspector: $/isar_community_inspector: /g' ./packages/isar_inspector/pubspec.yaml

# Update the name in test.yaml file, respecting YAML indentation
sed -i 's#^\(\s*\)isar$#\1isar_community#g' ./packages/isar_flutter_libs/pubspec.yaml
sed -i 's#^\(\s*\)isar$#\1isar_community#g' ./packages/isar_generator/pubspec.yaml
sed -i 's#^\(\s*\)isar:$#\1isar_community:#g' ./packages/isar_inspector/pubspec.yaml
sed -i 's#^\(\s*\)\/isar:$#\1\/isar_community:#g' ./packages/isar_inspector/pubspec.yaml

sed -i 's#isar:#isar_community:#g' ./packages/isar_flutter_libs/pubspec.yaml
sed -i 's#isar:#isar_community:#g' ./packages/isar_generator/pubspec.yaml
sed -i 's#/isar#/isar_community#g' ./packages/isar_inspector/pubspec.yaml

sed -i 's#isar_generator:#isar_community_generator:#g' ./packages/isar_generator/build.yaml
sed -i 's#package:isar_generator#package:isar_community_generator#g' ./packages/isar_generator/build.yaml



sed -i 's#^\(\s*\)isar_flutter_libs$#\1isar_community_flutter_libs#g' ./.github/workflows/test.yaml
sed -i 's#^\(\s*\)isar_generator$#\1isar_community_generator#g' ./.github/workflows/test.yaml
sed -i 's#^\(\s*\)isar_inspector$#\1isar_community_inspector#g' ./.github/workflows/test.yaml


# Update the name in test.yaml file, respecting YAML indentation
sed -i 's#^\(\s*\)working-directory: packages/isar$#\1working-directory: packages/isar_community#g' ./.github/workflows/test.yaml
sed -i 's#^\(\s*\)working-directory: packages/isar_flutter_libs$#\1working-directory: packages/isar_community_flutter_libs#g' ./.github/workflows/test.yaml
sed -i 's#^\(\s*\)working-directory: packages/isar_generator$#\1working-directory: packages/isar_community_generator#g' ./.github/workflows/test.yaml
sed -i 's#^\(\s*\)working-directory: packages/isar_inspector$#\1working-directory: packages/isar_community_inspector#g' ./.github/workflows/test.yaml

sed -i 's#isar:#isar_community:#g' ./examples/pub/pubspec.yaml
sed -i 's#isar_flutter_libs:#isar_community_flutter_libs:#g' ./examples/pub/pubspec.yaml
sed -i 's#isar_generator:#isar_community_generator:#g' ./examples/pub/pubspec.yaml


sed -i 's#isar:#isar_community:#g' ./packages/isar_test/pubspec.yaml
sed -i 's#isar_flutter_libs:#isar_community_flutter_libs:#g' ./packages/isar_test/pubspec.yaml
sed -i 's#isar_generator:#isar_community_generator:#g' ./packages/isar_test/pubspec.yaml


# EXAMPLES / DEBUG APENAS, NAO DEVE FICAR COM ANY NEM OVERRIDES
sed -i 's/^\Sisar_generator: *isar_version$/isar_community_generator: any/g' ./examples/pub/pubspec.yaml
sed -i 's/^\sisar_flutter_libs: *isar_version$/isar_community_flutter_libs: any/g' ./examples/pub/pubspec.yaml
sed -i 's/^\sisar: *isar_version$/isar_community: any/g' ./examples/pub/pubspec.yaml
cat <<EOF >> ./examples/pub/pubspec.yaml


dependency_overrides:
  isar_community:
    path: ../../packages/isar_community
  isar_community_flutter_libs:
    path: ../../packages/isar_community_flutter_libs

  # dev
  isar_community_generator:
    path: ../../packages/isar_community_generator
EOF


# DEBUG APENAS, NAO DEVE FICAR COM ANY NEM OVERRIDES
sed -i 's/^\Sisar_generator: *isar_version$/isar_community_generator: any/g' ./packages/isar_test/pubspec.yaml
sed -i 's/^\sisar_flutter_libs: *isar_version$/isar_community_flutter_libs: any/g' ./packages/isar_test/pubspec.yaml
sed -i 's/^\sisar: *isar_version$/isar_community: any/g' ./packages/isar_test/pubspec.yaml
cat <<EOF >> ./packages/isar_test/pubspec.yaml


dependency_overrides:
  isar_community:
    path: ../isar_community
  isar_community_flutter_libs:
    path: ../isar_community_flutter_libs

  # dev
  isar_community_generator:
    path: ../isar_community_generator
EOF



# DEBUG APENAS, NAO DEVE FICAR COM ANY NEM OVERRIDES
cat <<EOF >> ./packages/isar_flutter_libs/pubspec.yaml

dependency_overrides:
  isar_community:
    path: ../isar_community
EOF


# DEBUG APENAS, NAO DEVE FICAR COM ANY NEM OVERRIDES
cat <<EOF >> ./packages/isar_generator/pubspec.yaml

dependency_overrides:
  isar_community:
    path: ../isar_community
EOF



# POR FIM, RENOMEAR OS FOLDERS (NAO É DEBUG)
mv ./packages/isar ./packages/isar_community
mv ./packages/isar_flutter_libs ./packages/isar_community_flutter_libs
mv ./packages/isar_generator ./packages/isar_community_generator
mv ./packages/isar_inspector ./packages/isar_community_inspector
