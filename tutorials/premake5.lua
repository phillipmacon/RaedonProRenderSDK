function fileExists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function os.winSdkVersion()
   local reg_arch = iif( os.is64bit(), "\\Wow6432Node\\", "\\" )
   local sdk_version = os.getWindowsRegistry( "HKLM:SOFTWARE" .. reg_arch .."Microsoft\\Microsoft SDKs\\Windows\\v10.0\\ProductVersion" )
   if sdk_version ~= nil then return sdk_version end
end

solution "Tutorials"
	configurations { "Debug", "Release" }    		
	language "C++"
	flags { "NoMinimalRebuild" }
    vectorextensions "SSE"
    vectorextensions "SSE2"
    -- define common includes
    includedirs { ".","../RadeonProRender/include" }

    -- perform OS specific initializations
    local targetName;
    if os.istarget("macosx") then
        targetName = "osx"
		platforms {"x64"}
	else
		platforms {"x64"}
	end
	
    if os.istarget("windows") then
        targetName = "win"
		defines{ "WIN32" }
        if _ACTION == "vs2010" then
            buildoptions { "/MP"  } --multiprocessor build
            defines {"_CRT_SECURE_NO_WARNINGS"}
            configuration {"Release"}
        end
	end

	if os.istarget("windows") then
		os.execute("xcopy /Y \"..\\RadeonProRender\\binWin64\\RadeonProRender64.dll\" \".\\Bin\\\"")
		os.execute("xcopy /Y \"..\\RadeonProRender\\binWin64\\RprLoadStore64.dll\" \".\\Bin\\\"")
		os.execute("xcopy /Y \"..\\RadeonProRender\\binWin64\\Tahoe64.dll\" \".\\Bin\\\"")
		os.execute("xcopy /Y \"..\\RadeonProRender\\binWin64\\Northstar64.dll\" \".\\Bin\\\"")
		os.execute("xcopy /Y \"..\\RadeonProRender\\binWin64\\Hybrid.dll\" \".\\Bin\\\"")
		os.execute("xcopy /Y \"..\\RadeonProRender\\binWin64\\ProRenderGLTF.dll\" \".\\Bin\\\"")
	end

    configuration "Debug"
		defines { "_DEBUG" }
		symbols "On"
	configuration "Release"
		defines { "NDEBUG" }

	configuration {"x64", "Debug"}
		targetsuffix "64D"

	configuration {"x64", "Release"}
		targetsuffix "64"
    
    configuration {} -- back to all configurations
	if os.istarget("windows") then
                systemversion(os.winSdkVersion() .. ".0")
                libdirs {"../RadeonProRender/libWin64" }
	end
	if os.istarget("linux") then
		defines{ "__LINUX__" }
		libdirs {"../RadeonProRender/binUbuntu18" }
	end
	if os.istarget("macosx") then
		libdirs {"../RadeonProRender/binMacOS" }
	end

	defines{ "RPR_API_USE_HEADER_V2" }  -- make sure to use the API V2: it's a safer C API

	include "00_context_creation"
	include "03_parameters_enumeration"
	include "05_basic_scene"
	include "12_transform_motion_blur"
	include "13_deformation_motion_blur"
	include "17_camera_dof"
	include "21_material"
	include "22_material_uber"
	include "23_twosided"
	include "24_contour"
	include "25_toon"
	include "26_materialx"
	include "27_cutplanes"
	include "30_tiled_render"
	include "31_framebuffer_access"
	include "32_gl_interop"
	include "33_aov"
	include "50_curve"
	include "51_volume"
	include "60_mesh_export"
	include "61_mesh_import"
 	include "63_hybrid"
    include "64_mesh_obj_demo"
    include "65_mesh_convert"

	if fileExists("./MultiTutorials/MultiTutorials.lua") then
		dofile("./MultiTutorials/MultiTutorials.lua")
	end
		
	
	if fileExists("./parameters_enumeration/parameters_enumeration.lua") then
		dofile("./parameters_enumeration/parameters_enumeration.lua")	
	end


