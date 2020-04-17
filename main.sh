#!/bin/bash

# ########################## create voi timecourses #############################

fname='abcdmid'
postproc=$fname'_mbnf'
maskdir='/home/span/fmri/abcdmid/masks'
masks='wm_mask csf_mask nacc8mm nacc_desai_mpm ins desai_ins mpfc amyg_mask caudate antins_desai_mpm acing'

for maskname in $masks
do
	cp $maskdir'/'$maskname+tlrc* .
	3dfractionize -overwrite -template $postproc+orig -input $maskname+tlrc -preserve -warp anat+tlrc -clip 0.1  -prefix $maskname'r'+orig
	3dmaskave -mask $maskname'r'+orig -quiet -mrange 1 1 $postproc+orig > $postproc'_'$maskname'_l.1D'
	3dmaskave -mask $maskname'r'+orig -quiet -mrange 2 2 $postproc+orig > $postproc'_'$maskname'_r.1D'
	3dmaskave -mask $maskname'r'+orig -quiet -mrange 1 2 $postproc+orig > $postproc'_'$maskname'_b.1D'
done
