# CBQN/BQN machbldr.bqn
# bqns machbldr.bqn --projects ssacore swsservice --actions build --clean

# tests
# args ← "--projects"‿"ssacore"‿"swsservice"‿"--actions"‿"build"‿"--clean"

GetValue ← {((0⊑𝕨)⊐⟨𝕩⟩)⊑1⊑𝕨}  # TODO clean, tacit

GetValueDefault ← {𝕨 {⊑⟨𝕩⟩∊0⊑𝕨}◶{𝕨 GetValue "default"}‿{𝕨 GetValue 𝕩} 𝕩}  # TODO clean, tacit

args_short ← ⟨
  "-p"‿"--projects"
  "-a"‿"--actions"
⟩

mlibraries ← ⟨
  "ssacore"
  "turboprop"
  "sdacore"
  "svslib"
  "xcomlib"
⟩
•Out "mlibraries: "∾•Fmt mlibraries

mapplications ← ⟨
  "swsservice"
  "catalogservice"
  "xcom"
  "tpmservice"
  "traidservice"
  "age"
  "SatView"
  "Obs2Tle"
⟩

mexc_paths ← ⟨
  "swsservice"‿"swsservice/bin/sws-service"
  "catalogservice"‿"catalogservice/bin/CatalogCoordinator"
  "xcom"‿"xcom/bin/xcom"
  "tpmservice"‿"tpmservice/bin/tpm"
  "traidservice"‿"traidservice/bin/Traid"
  "age"‿"age/bin/age"
  "SatView"‿"core/tools/SatView/SatView"
  "Obs2Tle"‿"core/tools/Obs2Tle/Obs2Tle"
⟩

#def get_dirproj(project):
#    if project == "SatView":
#        return "core/tools/SatView"
#    if project == "Obs2Tle":
#        return "core/tools/Obs2Tle"
#    else:
#        return project

mproject_deps ← <˘⍉>⟨
  "ssacore"‿⟨⟩
  "turboprop"‿⟨⟩
  "sdacore"‿⟨"ssacore", "turboprop"⟩
  "catalogservice"‿⟨"sdacore"⟩
  "swsservice"‿⟨"sdacore"⟩
  "svslib"‿⟨"sdacore"⟩
  "xcomlib"‿⟨"sdacore"⟩
  "xcom"‿⟨"xcomlib", "svslib"⟩
  "traidservice"‿⟨"sdacore"⟩
  "tpmservice"‿⟨"sdacore"⟩
  "age"‿⟨"sdacore"⟩
  "SatView"‿⟨"sdacore"⟩
  "Obs2Tle"‿⟨"sdacore"⟩
⟩

mcleans ← <˘⍉>⟨
  "packages-install"‿"packages-install-clean"
  "config"‿"config-clean"
  "build"‿"build-clean"
⟩

#def get_project_deps(prj):
#    if prj not in _project_deps:
#        return [prj]
#    return (
#        list(
#            itertools.chain.from_iterable(
#                get_project_deps(x)
#                for x in _project_deps[prj]
#            ))
#        + [prj]
#    )

mprojects ← mlibraries ∾ mapplications

mactions ← <˘⍉>⟨
    "packages-install-clean"‿(<˘⍉>⟨
        "default"‿⟨
          "rm -rf {dirproj}/conan/conan.lock"
          "rm -rf {dirproj}/conan/conanbuildinfo.cmake"
          "rm -rf {dirproj}/conan/conanbuildinfo.mak"
          "rm -rf {dirproj}/conan/conanbuildinfo.txt"
          "rm -rf {dirproj}/conan/conaninfo.txt"
          "rm -rf {dirproj}/conan/graph_info.json"
        ⟩
        "SatView"‿⟨⟩
        "Obs2Tle"‿⟨⟩
    ⟩)
    "packages-install"‿(<˘⍉>⟨
        "default"‿⟨
          "rm -rf {dirproj}/conan/conan.lock"
          "rm -rf {dirproj}/conan/conanbuildinfo.cmake"
          "rm -rf {dirproj}/conan/conanbuildinfo.mak"
          "rm -rf {dirproj}/conan/conanbuildinfo.txt"
          "rm -rf {dirproj}/conan/conaninfo.txt"
          "rm -rf {dirproj}/conan/graph_info.json"
        ⟩
        "ssacore"‿⟨⟩
        "turboprop"‿⟨⟩
        "SatView"‿⟨⟩
        "Obs2Tle"‿⟨⟩
    ⟩)
    "pre-build"‿(<˘⍉>⟨
        "default"‿⟨⟩
        "sdacore"‿⟨
           "pushd {dirproj}"
           "./scripts/autorevision -t hpp > src/sdacore_autorev.hpp"
           "popd"
        ⟩
    ⟩)
    "config-clean"‿(<˘⍉>⟨
        "default"‿⟨
          "rm -rf \
{dirproj}/CMakeFiles \
{dirproj}/CMakeCache.txt \
{dirproj}/err.txt \
{dirproj}/cmake_install.cmake"
        ⟩
        "ssacore"‿⟨
          "rm -rf {dirproj}/buildmb"
        ⟩
        "turboprop"‿⟨⟩
    ⟩)
    "config"‿(<˘⍉>⟨
      "default"‿⟨
        "cmake \
-DWITH_CONAN=1 \
-S {dirproj} \
-B {dirproj} \
-Dstatic_force_no={static_force_no} \
-Duse_kafka={use_kafka}"
      ⟩
      "ssacore"‿⟨
        "cmake \
-S {dirproj} \
-B {dirproj}/buildmb \
-DSANITIZE=OFF \
-Dmodern_practice=ON \
-Duse_kafka={use_kafka}"
      ⟩
      "turboprop"‿⟨⟩
      "svslib"‿⟨
        "cmake \
.-DWITH_CONAN=1 \
-DUSE_ACTIVEMQ:BOOL=ON \
-S {dirproj} \
-B {dirproj}"
      ⟩
      "xcomlib"‿⟨
         "cmake \
-DWITH_CONAN=1 \
-DUSE_ACTIVEMQ:BOOL=ON \
-S {dirproj} \
-B {dirproj} \
-Dstatic_force_no={static_force_no}"
      ⟩
      "xcom"‿⟨
         "cmake -DWITH_CONAN=1 \
-S {dirproj} \
-B {dirproj} \
-DCMAKE_BUILD_TYPE=Debug \
-Dstatic_force_no={static_force_no} \
-Duse_kafka={use_kafka}"
      ⟩
      "age"‿⟨
        "cmake -DWITH_CONAN=1 -DWITH_SERVICE=1 \
-S {dirproj} \
-B {dirproj} \
-DCMAKE_BUILD_TYPE=Debug \
-Dstatic_force_no={static_force_no} \
-Duse_kafka={use_kafka}"
      ⟩
    ⟩)
    "build-clean"‿(<˘⍉>⟨
      "default"‿⟨
        "make -C {dirproj} clean"
      ⟩
      "ssacore"‿⟨
        "cmake --build {dirproj}/buildmb --target clean"
      ⟩
      "xcomlib"‿⟨⟩
    ⟩)
    "build"‿(<˘⍉>⟨
      "default"‿⟨
        "make -C {dirproj} --jobs={nprocs}"
      ⟩
      "ssacore"‿⟨
        "cmake --build {dirproj}/buildmb --parallel={nprocs}"
      ⟩
    ⟩)
    "post-build"‿(<˘⍉>⟨
      "default"‿⟨⟩
      "ssacore"‿⟨
        "mkdir -p {dirproj}/lib"
        "cp {dirproj}/buildmb/src/libSSA.a {dirproj}/lib/."
        "cp {dirproj}/buildmb/src/ssa_config.h {dirproj}/src/."
        "cp {dirproj}/buildmb/src/ssacore_autorev.hpp {dirproj}/src/."
      ⟩
      "turboprop"‿⟨
        "mkdir -p {dirproj}/lib"
        "cp {dirproj}/src/libTurboProp.a {dirproj}/lib/."
      ⟩
    ⟩)
    "package-export"‿(<˘⍉>⟨
      "default"‿⟨⟩
      "ssacore"‿⟨
        "conan export-pkg -bf {dirproj} --force {dirproj}/conanfile.py \
{project}/MACHINA-latest@pipeline/testing"
      ⟩
      "sdacore"‿⟨
        "conan export-pkg -bf {dirproj} --force {dirproj}/conanfile.py \
{project}/MACHINA-latest@pipeline/testing"
      ⟩
      "turboprop"‿⟨
        "conan export-pkg -bf {dirproj} --force {dirproj}/conanfile.py \
{project}/MACHINA-latest@pipeline/testing"
      ⟩
      "svslib"‿⟨
        "conan export-pkg -bf {dirproj} --force {dirproj}/conanfile.py \
{project}/MACHINA-latest@pipeline/testing"
      ⟩
      "xcomlib"‿⟨
        "conan export-pkg -bf {dirproj} --force {dirproj}/conanfile.py \
{project}/MACHINA-latest@pipeline/testing"
      ⟩
    ⟩)
    "build-image"‿(<˘⍉>⟨
      "default"‿⟨⟩
    ⟩)
⟩

•Out "config-xcom"
•Show (mactions GetValue "config") GetValue "xcom"
•Out "build-xcom"
•Show (mactions GetValue "build") GetValueDefault "xcom"

ReplaceStringsInList ← {
  a ← 0⊑𝕨
  b ← 1⊑𝕨
  b¨⌾((a⊸≡¨𝕩)/○⥊⊢)𝕩  # TODO study this
}

SortWithList ← {
  (⍋⍋⍋𝕨⊐𝕩)⊏𝕩  # TODO study this
}

GetArgParams ← {
  x ← ((𝕨⊸≡⊑)¨)⊸/𝕩
  x (∾(1⊸↓)¨)↩
  x
}

GetArgsParams ← {
  GetArgParams⟜𝕩¨𝕨
}

args ← •args

## convert single character argmuments to long arguments; -p -> --projects
# TODO turn into function that takes arbitrary number of replacements, args_short
#args "-p"‿"--projects"⊸ReplaceStringsInList↩
#args "-a"‿"--actions"⊸ReplaceStringsInList↩
args (0⊑args_short)⊸ReplaceStringsInList↩  # projects
args (1⊑args_short)⊸ReplaceStringsInList↩  # actions
#ConvertShortArgs ← {
#{"--projects"¨⌾(("-p"⊸≡¨𝕩)/○⥊⊢)𝕩}args
#}
#args args_short ConvertShortArgs ↩
•Out "original args: "∾•Fmt args

## group arguments with their sub-arguments, if any
#args ← (+`("--"⊸≡2⊸↑)¨)⊸⊔ •args  # group flags with args
{  # block to limit scope of temp vars
  loc_args ← ("--"⊸≡2⊸↑)¨ args  # locate args
  grp_args ← +`loc_args  # prep to group
  args grp_args⊸⊔↩  # group args
}
args (¬⟨⟩⊸≡)¨⊸/↩  # remove empty elements
# TODO convert args to fake association list / dictionary; find out what this means in bqn
•Out "args: "∾•Fmt args

projects‿actions ← "--projects"‿"--actions" GetArgsParams args
•Out "original projects: "∾•Fmt projects
•Out "original actions: "∾•Fmt actions

dep_projects‿dep_actions‿clean ← (⋈¨"--dep-projects"‿"--dep-actions"‿"--clean") ∊ args
•Out "dep_projects: "∾•Fmt dep_projects
•Out "dep_actions: "∾•Fmt dep_actions
•Out "clean: "∾•Fmt clean

projects (mprojects SortWithList ⍷)↩  # TODO study this
GetDependentProjects ← {
  ⟨𝕩⟩∾∾GetDependentProjects¨mproject_deps GetValue 𝕩
}
FillDependentProjects ← {
  (≠𝕩)=1 ? mprojects SortWithList ⍷GetDependentProjects⊑𝕩;
  # if first project is a library, assign to base_library, else first library in mlibraries
  base_library ← (⊑mlibraries∊⊑𝕩) ◶ (⊑𝕩)‿(⊑mlibraries) @
  x ← ∾GetDependentProjects¨𝕩
  x ⟨base_library⟩⊸∾↩
  x (mprojects⊸SortWithList ⍷)↩
  # remove any libraries the precede base_library
  x (⊑x⊒⟨base_library⟩)⊸↓↩
}
projects ↩ FillDependentProjects⍟dep_projects projects
•Out "final projects: "∾•Fmt projects

actions ((⊑mactions) SortWithList ⍷)↩
original_cleans ← (∨´"clean"⊸⍷)¨⊸/actions
FillDependentActions ← {
  (≠𝕩)=1 ? (1+(⊑mactions)⊒𝕩)↑(⊑mactions);
  ix_action_first ← ⊑(⊑mactions)⊒⟨0⊑𝕩⟩
  ix_action_last ← 1 + ⊑(⊑mactions)⊒⟨¯1⊑𝕩⟩
  (↕⌾(-⟜ix_action_first)ix_action_last) ⊏ (⊑mactions)  # TODO study this
}
actions ↩ FillDependentActions⍟dep_actions actions
actions (¬(∨´"clean"⊸⍷))¨⊸/↩  # remove any "clean" actions
actions ↩ actions ∾ {((⊑mcleans) ∊ 𝕩) / 1⊑mcleans} ⍟ clean actions
actions original_cleans⊸∾↩
actions ((⊑mactions) SortWithList ⍷)↩

•Out "final actions: "∾•Fmt actions
