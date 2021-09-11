t6x reaver port for android *UNTESTED
*might still have bugs

Based on kriswebdev's port of reaver https://github.com/kriswebdev/android_reaver-wps

To Build:
	*it is recommended to use the nexmon branch of this repo

	Android Source:
		copy master branch to external/reaver in android source

	Nexmon:
		copy the nexmon branch of this repo to the utilities folder of nexmon and build in that environment

To Build Wash:
	Wash is build/made by symlinking reaver: ln -sf reaver wash

	Otherwise it can be rebuilt by uncommenting wash in Android.mk 
	and for nexmon by using Makefile-wash instead of normal one