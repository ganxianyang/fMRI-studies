clear dat
dat = fmri_data('VIDS.nii', 'Putamen.nii');
regions = region(dat);
coordinate=regions(1, 1).XYZmm';
tabulate(coordinate(:,1))
info = roi_contour_map(regions(1,1), 'cluster', 'use_same_range', 'xyz', 1, 'coord', 32);
set(gca, 'XDir','reverse')
set(gcf, 'Color', 'w');

clear dat
dat = fmri_data('VIDS.nii', 'ACC.nii');
regions = region(dat);
coordinate=regions(1, 1).XYZmm';
tabulate(coordinate(:,3))
info = roi_contour_map(regions(1,1), 'cluster', 'use_same_range', 'xyz', 3, 'coord', 24);
set(gca, 'XDir','reverse')
set(gcf, 'Color', 'w');

clear dat
dat = fmri_data('VIDS.nii', 'PAG.nii');
regions = region(dat);
coordinate=regions(1, 1).XYZmm';
tabulate(coordinate(:,1))
info = roi_contour_map(regions(1,1), 'cluster', 'use_same_range', 'xyz', 1, 'coord', -4);
set(gca, 'XDir','reverse')
set(gcf, 'Color', 'w');

clear dat
dat = fmri_data('VIDS.nii', 'left_insula.nii');
regions = region(dat);
coordinate=regions(1, 1).XYZmm';
tabulate(coordinate(:,3))
info = roi_contour_map(regions(1,1), 'cluster', 'use_same_range', 'xyz', 3, 'coord', -2);
set(gca, 'XDir','reverse')
set(gcf, 'Color', 'w');

clear dat
dat = fmri_data('VIDS.nii', 'right_insula.nii');
regions = region(dat);
coordinate=regions(1, 1).XYZmm';
tabulate(coordinate(:,3))
info = roi_contour_map(regions(1,1), 'cluster', 'use_same_range', 'xyz', 3, 'coord', -2);
set(gca, 'XDir','reverse')
set(gcf, 'Color', 'w');

clear dat
dat = fmri_data('VIDS.nii', 'left_amy.nii');
regions = region(dat);
coordinate=regions(1, 1).XYZmm';
tabulate(coordinate(:,2))
info = roi_contour_map(regions(1,1), 'cluster', 'use_same_range', 'xyz', 2, 'coord', -2);
set(gca, 'XDir','reverse')
set(gcf, 'Color', 'w');

clear dat
dat = fmri_data('VIDS.nii', 'right_amy.nii');
regions = region(dat);
coordinate=regions(1, 1).XYZmm';
tabulate(coordinate(:,2))
info = roi_contour_map(regions(1,1), 'cluster', 'use_same_range', 'xyz', 2, 'coord', -2);
set(gca, 'XDir','reverse')
set(gcf, 'Color', 'w');





