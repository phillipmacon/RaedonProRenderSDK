project "50_curve"
    kind "ConsoleApp"
    location "../build"
    files { "../50_curve/**.h", "../50_curve/**.cpp"} 
    files { "../common/common.cpp","../common/common.h"}

    -- remove filters for Visual Studio
    vpaths { [""] = { "../50_curve/**.h", "../50_curve/**.cpp","../common/common.cpp","../common/common.h"} }


    includedirs{ "../../RadeonProRender/inc" } 
    
    buildoptions "-std=c++11"

	configuration {"x64"}
	links {"RadeonProRender64"}
	
    configuration {"x64", "Debug"}
        targetdir "../Bin"
    configuration {"x64", "Release"}
        targetdir "../Bin"
    configuration {}
    
