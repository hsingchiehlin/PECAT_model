# ALL Switch on (SI + LI)
Integrate (Lsodes, 1e-12, 1e-12, 1);

MonteCarlo ("",10000,11920);

# Absorption on(1)/off(0) switches
f_Abs_stom  = 0;
#f_Abs_duod  = 0;
#f_Abs_jeju  = 0;
#f_Abs_ileum = 0;
#f_Abs_cecum = 0;
#f_Abs_colon = 0;

s_jeju_ratio = 1;

# put peff ratio distributions
Peff_ratio_duod_jeju = 1;
Peff_ratio_ileum_jeju = 1;
Peff_ratio_colon_jeju = 1;
Peff_ratio_ivive = 1;

# Switches off intestine epithilia and kidney metabolite
Vmax_met_vitro_intestine = 0;
Peff = 1.138420e-02;
Distrib(Ratio_BP, Uniform, 0.52, 2.11);
Distrib(Fu_plasma, Uniform, 0.02, 0.4);
Distrib(Fu_stom, Uniform, 0.02, 0.4);
Distrib(Fu_duod, Uniform, 0.02, 0.4);
Distrib(Fu_jeju, Uniform, 0.02, 0.4);
Distrib(Fu_ileum, Uniform, 0.02, 0.4);
Distrib(Fu_cecum, Uniform, 0.02, 0.4);
Distrib(Fu_colon, Uniform, 0.02, 0.4);
Distrib(Fu_liver, Uniform, 0.02, 0.4);
Distrib(Fu_kidney, Uniform, 0.02, 0.4);
Distrib(Fu_body, Uniform, 0.02, 0.4);
Distrib(Fu_vitro_stom, Uniform, 0.02, 0.4);
Distrib(Fu_vitro_duod, Uniform, 0.02, 0.4);
Distrib(Fu_vitro_jeju, Uniform, 0.02, 0.4);
Distrib(Fu_vitro_ileum, Uniform, 0.02, 0.4);
Distrib(Fu_vitro_cecum, Uniform, 0.02, 0.4);
Distrib(Fu_vitro_colon, Uniform, 0.02, 0.4);
Distrib(Fu_vitro_liver, Uniform, 0.02, 0.4);
Distrib(Fu_vitro_kidney, Uniform, 0.02, 0.4);
Distrib(Kpuu_stom, Uniform, 0.01, 10);
Distrib(Kpuu_duod, Uniform, 0.01, 10);
Distrib(Kpuu_jeju, Uniform, 0.01, 10);
Distrib(Kpuu_ileum, Uniform, 0.01, 10);
Distrib(Kpuu_cecum, Uniform, 0.01, 10);
Distrib(Kpuu_colon, Uniform, 0.01, 10);
Distrib(Kpuu_liver, Uniform, 0.01, 10);
Distrib(Kpuu_kidney, Uniform, 0.01, 10);
Distrib(Kpuu_body, Uniform, 0.01, 10);
Distrib(Vmax_met_vitro_liver, Uniform, 1e-6, 1e-2);


# using mean of post distribution 
# Weibull delayed release parameters
Weibull_slope_IR = 1; 
Weibull_slope_SR = 1; 
Weibull_slope_ER = 1.7802;
Weibull_scale_IR = 0.1741;
Weibull_scale_SR = 1.2392; 
Weibull_scale_ER = 2.1054;


Simulation{
  
  BDM = 73.4; 
  R_type = 0; 


  G_immediate_d = 1;
  Oral_dose_rate = 312.8389; #312.8389

  PrintStep (C_blood, 1,10000, 100);
  PrintStep (C_ss_equ, 1, 10000, 100);
  PrintStep (F_bio, 1, 10000, 100);


};

END.
