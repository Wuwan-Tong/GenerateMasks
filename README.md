- generate smooth and sharp masks according to the C code: run file main.m (smooth) , main_sharp.m (sharp), set up path where to save masks
    
  data mask is a 4D matrix: [ori=1&complement=2, wedge type, h\*h, w\*w] (like DCT bases on google image)  
- generate DCT bases (data and .png figures) for different block size: run generate_DCT_bases.m, set up path to save the data and figures, and using original or complement masks
    
  data DCT bases is a 2D matrix: [h\*h,w\*w] (like DCT bases on google image)  
- generate DCT dictionaries (data and .png figures) with original sharp masks and complement sharp masks: run DCT_dictionary.m, set up path where to load masks and DCT_bases and whare to save the data and figures, and choose using original or complement masks
    
  data DCT dictionary is a 5D matrix: [wedge type, h position, w position, h, w]  
- get correlation map (data and .png figures): run correlation_map.m, set up path where to load DCT dictionaries and where to save orrelation maps
    
  data correlation map is a 4D matrix: [h position, w position, h, w]  
  
- get coherence and [coherence without considering vertical and horizontal neighbors]: run coherence.m and coherence_Neighbor.m
    
  data coherence is a 1D array: [wedge type]  


- The folder structure is:
  
--(code files)
    
--masks  
  --------sharp  
      ---------------png_figs  
      ------------------------ori  
      ------------------------compl  
  --------smooth  
      ---------------png_figs  
      ------------------------ori  
      ------------------------compl  
    
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
  --------coh   
  ----------------ori  
  ----------------compl  
  --------coh_Nei    
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
