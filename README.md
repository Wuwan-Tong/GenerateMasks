- generate smooth and sharp masks according to the C code: run file main.m (smooth) , main_sharp.m (sharp), set up path where to save masks
- generate DCT bases (data and .png figures) for different block size: run generate_DCT_bases.m, set up path to save the data and figures, and using original or complement masks
- generate DCT dictionaries (data and .png figures) with original sharp masks and complement sharp masks: run DCT_dictionary.m, set up path where to load masks and DCT_bases and whare to save the data and figures, and choose using original or complement masks
- get correlation map (data and .png figures): run correlation_map.m, set up path where to load DCT dictionaries and where to save orrelation maps
- get coherence and [coherence without considering vertical and horizontal neighbors]: run coherence.m and coherence_Neighbor.m


- The folder structure is:
  
--(code files)
    
--masks
  
  --------sharp  
  --------smooth  
    
--DCT_bases  
  --------data  
  --------png_figs  
      ----------------w8_h8  
      ----------------w8_h16  
      ----------------w8_h32  
      ----------------w16_h8  
      ----------------w16_h16  
      ----------------w16_h32  
      ----------------w32_h8  
      ----------------w32_h16  
      ----------------w32_h32  
        
--DCT_Dictionary  
  --------data  
  ----------------ori  
  ----------------compl  
  --------corr  
  ----------------data  
  ------------------------ori  
  ------------------------compl  
  ----------------png_figs  
  --------png_figs  
  ------------------------ori  
      --------------------------------w8_h8  
      --------------------------------w8_h16  
      --------------------------------w8_h32  
      --------------------------------w16_h8  
      --------------------------------w16_h16  
      --------------------------------w16_h32  
      --------------------------------w32_h8  
      --------------------------------w32_h16  
      --------------------------------w32_h32  
  ------------------------compl  
      --------------------------------w8_h8  
      --------------------------------w8_h16  
      --------------------------------w8_h32  
      --------------------------------w16_h8  
      --------------------------------w16_h16  
      --------------------------------w16_h32  
      --------------------------------w32_h8  
      --------------------------------w32_h16  
      --------------------------------w32_h32  
