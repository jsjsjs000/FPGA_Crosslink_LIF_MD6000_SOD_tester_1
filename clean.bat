@echo off

set org_dir=%cd%

rmdir /s /q LIF_MD6000_SOD_tester_1_tcr.dir
del .recovery
del *.ccl
del *.sty
del *.xml

for %%p in (impl1_gpio_test impl2_pll impl3_oled_svga060_test_image impl3_oled_sxga060_test_image impl4_dsi_to_oled_svga060) do (
	echo %%p%

	rmdir /s /q %%p%\.vdbs
	rmdir /s /q %%p\LIF_MD6000_SOD_tester_1_%%p.dir
	rmdir /s /q %%p\synlog
	rmdir /s /q %%p\syntmp
	rmdir /s /q %%p\synwork
	del %%p%\*.alt
	del %%p%\*.arearep
	del %%p%\*.areasrr
	del %%p%\*.asd
	del %%p%\*.bgn
	del %%p%\*.bit
	del %%p%\*.cam
	del %%p%\*.ccl
	del %%p%\*.drc
	del %%p%\*.hrr
	del %%p%\*.htm
	del %%p%\*.html
	del %%p%\*.ini
	del %%p%\*.log
	del %%p%\*.log.bak.1
	del %%p%\*.log.bak
	del %%p%\*.log.bak.2
	del %%p%\*.log.bak.3
	del %%p%\*.log.bak.4
	del %%p%\*.log.bak.5
	del %%p%\*.lsedata
	del %%p%\*.ngo
	del %%p%\*.mrp
	del %%p%\*.ncd
	del %%p%\*.ngd
	del %%p%\*.p2t
	del %%p%\*.p3t
	del %%p%\*.pad
	del %%p%\*.par
	del %%p%\*.prf
	del %%p%\*.pt
	del %%p%\*.rpt
	del %%p%\*.srd
	del %%p%\*.srf
	del %%p%\*.srm
	del %%p%\*.srr
	del %%p%\*.srr.db
	del %%p%\*.srs
	del %%p%\*.synproj
	del %%p%\*.t2b
	del %%p%\*.twr
	del %%p%\*_prim.v
	del %%p%\*.xml
	del %%p%\.build_status
	del %%p%\xxx_lse_cp_file_list
	del %%p%\xxx_lse_sign_file

	cd /d simulation\%%p%
	clean_out.bat
	cd /d %org_dir%
)
