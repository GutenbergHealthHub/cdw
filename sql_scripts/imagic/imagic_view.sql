-- show data of patients from 2012 without name in column im_name and null in column in im_originalfilename.
create view imagic.image_v as 
SELECT
  idimage,
 idstudy,
 iacreationdate,
 iacreationuser,
 iamodificationdate,
 iamodificationuser,
 iaguid,
 iaowner,
 iacreatinggroup,
 iamodificationgroup,
 i_imageid,
 i_modality,
 i_seriesinst,
 i_seriesnumb,
 i_seriesdesc,
 i_seriesdate,
 i_seriestime,
 i_perfphysif,
 i_perfphysig,
 i_perfphysim,
 i_perfphysip,
 i_perfphysio,
 i_operatorsf,
 i_operatorsg,
 i_operatorsm,
 i_operatorpr,
 i_operatorpo,
 i_patientpos,
 i_manufact,
 i_manufacmod,
 i_imagetyppd,
 i_imagetyppe,
 i_acquisitio,
 i_contentda,
 i_contentti,
 i_conversion,
 i_instancenu,
 i_sopclauid,
 i_sopinstuid,
 i_transfersy,
 i_photointer,
 i_numberoffr,
 i_rows,
 i_columns,
 i_bitsalloc,
 i_bitsstored,
 i_scdate,
 i_sctime,
 i_storetopac,
 i_storedinp,
 i_commitedfp,
 i_sampelspp,
 i_planarcfg,
 i_highbit,
 i_pixelrepr,
 i_patorient,
 im_folderindex,
 im_idmeasurement,
 im_filename,
 im_netdrivename,
 im_volumelabel,
 im_volumetype,
 im_filesize,
 im_filedate,
 im_name,
 im_format,
 im_formatoptiontext,
 im_formatoption,
 im_width,
 im_height,
 im_bitsperpixel,
 im_insertiondate,
 im_insertionuser,
 im_modificationdate,
 im_modificationuser,
 im_computersource,
 im_sourcename,
 im_sourcewidth,
 im_sourceheight,
 im_sourcexratio,
 im_sourceyratio,
 im_micid,
 im_micname,
 im_micobjid,
 im_micobjpos,
 im_micobjname,
 im_micobjmagnification,
 im_micoptid,
 im_micoptpos,
 im_micoptname,
 im_micoptmagnification,
 im_micxpos,
 im_micypos,
 im_miczpos,
 im_micflags,
 im_flags,
 im_xmeterperpixel,
 im_ymeterperpixel,
 im_calibrationname,
 im_scrmode,
 im_scrkey,
 im_imageorigin,
 im_origcheckhash,
 im_positioncounter,
 iadeleted,
 iareadonly,
 i_bodypartex,
 i_laterality,
 im_downloadcount,
 iasync,
 null im_originalfilename,
 im_imsserverid,
 i_imgsample,
 xml_flagext,
 xml_f_relevant,
 sortperstudy,
 gsd_a_zeit,
 gsd_a_region,
 gsd_a_art,
 gsd_a_para,
 gsd_a_loka,
 exif_datetime1,
 i_imagecomm,
 im_coordlong,
 im_coordlat,
 im_imsfiletype,
 c_bildlokal,
 i_failedstore1,
 i_failstoinp,
 im_framerate,
 i_devacdate,
 i_acquisida,
 i_acquisiti
FROM imagic.image
where iacreationdate > '2012-01-01 00:00:00' 
and im_name ~'^imag|^IMG|^DSC|^Bild|^BILD|^Imag' 
order by iacreationdate;
