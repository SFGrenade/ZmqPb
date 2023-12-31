add_rules("mode.debug", "mode.release")
add_rules("plugin.compile_commands.autoupdate", {outputdir = ".vscode"})

set_project("ZmqPb")

if is_plat("windows") then
    set_languages("cxxlatest")

    -- bruh
    add_defines("_WIN32_WINNT=0x0601")

    add_cxflags("/Zc:__cplusplus")
    add_cxflags("/Zc:preprocessor")

    add_cxflags("/permissive-")
else
    set_languages("cxx20")
end

add_requires("cppzmq")
add_requires("protobuf-cpp")

set_warnings("allextra")

if is_mode("debug") then
    add_defines("DEBUG")

    set_symbols("debug")
    if is_plat("windows") then
        add_cxflags("/Zi")
        add_cxflags("/ZI")
    else
    end

    set_optimize("fastest")
end

if is_mode("release") then
    add_defines("NDEBUG")

    if is_plat("windows") then
        add_cxflags("/Qpar")
    else
        add_cxflags("-fomit-frame-pointer")
    end

    set_optimize("fastest")
end

target("ZmqPb")
    set_kind("static")

    add_packages("cppzmq")
    add_packages("protobuf-cpp")

    add_rules("protobuf.cpp")

    add_includedirs("include")
    add_headerfiles("include/(zmqPb/*.hpp)")
    add_files("proto/zmqPb/*.proto")
    add_files("src/*.cpp")
