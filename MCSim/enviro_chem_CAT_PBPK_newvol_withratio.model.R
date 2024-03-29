# -------------------------------------------------------------------------
# enviro_chem_cat_pbpk.model
#
# Units:
# - time in hours
# - volumes in liters
# - masses of substances in micromoles
# - concentrations of substances in microM
#
# Combine revised ACAT model with traditional PBPK model
# -------------------------------------------------------------------------

States  = { 
#  Q_central,      # Quantity in central compartment (micromoles)
#  Q_periph,       # ~           peripheral compartment
  Q_blood,        # Quantity in blood compartment (micromoles)
  Q_liver,        # ~           liver
  Q_kidney,       # ~           kidney
  Q_body,         # ~           body
  
  Q_to_release,   # ~        to release in stomach
  Q_released,     # ~        released in stomach
  
  Q_stom_lu_d,    # ~        in stomach  lumen (dissolved)
  Q_duod_lu_d,    # ~           duodenum ~     ~
  Q_jeju_lu_d,    # ~           jejunum  ~     ~
  Q_ileum_lu_d,   # ~           ileum    ~     ~
  Q_cecum_lu_d,   # ~           cecum    ~     ~
  Q_colon_lu_d,   # ~           colon    ~     ~

  Q_stom_ep,      # ~           stomach epithelium
  Q_duod_ep,      # ~           duodenum epithelium
  Q_jeju_ep,      # ~           jejunum epithelium
  Q_ileum_ep,     # ~           ileum epithelium
  Q_cecum_ep,     # ~           cecum epithelium
  Q_colon_ep,     # ~           colon epithelium
  
  Q_stom_w,       # ~           stomach wall
  Q_duod_w,       # ~           duodenum wall
  Q_jeju_w,       # ~           jejunum wall
  Q_ileum_w,      # ~           ileum wall
  Q_cecum_w,      # ~           cecum wall
  Q_colon_w,      # ~           colon wall
  
  Q_absorb_stom,  # ~           absorbed from stomach lumen
  Q_absorb_duod,
  Q_absorb_jeju,
  Q_absorb_ileum,
  Q_absorb_cecum,
  Q_absorb_colon,
  Q_absorb_pv,    # ~           reaching the portal vein
  
#  Q_elim_central, # ~           metabolized or excreted from central
  Q_met_stom,
  Q_met_duod,
  Q_met_jeju,
  Q_met_ileum,
  Q_met_cecum,
  Q_met_colon,
  Q_met_liver,
  Q_met_kidney,
  
  Q_feces_d,      # ~           excreted dissolved   in feces
  Q_urine,
  
  AUC_blood
};


Outputs = { 
#  C_central,        # Concentration in central compartment (microM)
#  C_central_ngml,   # Concentration in central compartment (ng/ml)
#  lnC_central_ngml, # log(Concentration in central compartment) (ng/ml)
#  C_periph,         #                  peripheral
  
  C_blood,        # Quantity in blood compartment (microM)
  C_blood_ngml,   # Concentration in blood compartment (ng/ml)
  lnC_blood_ngml, # log(Concentration in blood compartment) (ng/ml)
  C_liver,        # ~           liver
  C_kidney,       # ~           kidney
  C_body,         # ~           body
  
  C_stom_lu_d,      #                  stomach lumen (dissolved)
  C_duod_lu_d,
  C_jeju_lu_d,
  C_ileum_lu_d,
  C_cecum_lu_d,
  C_colon_lu_d,
  
  C_stom_ep,
  C_duod_ep,
  C_jeju_ep,
  C_ileum_ep,
  C_cecum_ep,
  C_colon_ep,
  
  C_stom_w,
  C_duod_w,
  C_jeju_w,
  C_ileum_w,
  C_cecum_w,
  C_colon_w,
  
  CL_int,
  E_pbpk,
  E_equ,
  C_ss_equ,

# below section using for check mass balance
  Q_gi_lu_d,      # Quantity in g.i. tract lumen (dissolved)
  Q_gi_ep,        # ~                      epithelium
  Q_gi_w,         # ~                      wall
  Q_absorb,       # ~ absorbed by the g.i. tract
  Q_elim,         # ~ metabolized or excreted
  Q_met_gi,       # ~ metabolized in the g.i. tract
  Q_elim_gi,      # ~ metabolized in or excreted from the g.i. tract
  Q_organ,        # ~ in the body (including lumina)
  Q_total,        # ~ in the body and metabolized or excreted
  K_release,
  Release_rate,   # Instantaneous release rate for delayed forms
  Instant_Ka_gi,  # Instantaenous net absorption ratio by g.i. tract
  F_bio,           # Bioavailability
  Q_gut,
  Cu_liver,
  Cu_blood
  
};         

Inputs = { 
  Oral_dose_rate,  # micromoles / h (?)
  IV_dose_rate,    # immediate dose, in micromoles / h 
  PO_dose,         # delayed oral dose, in micromoles
  events_v1
  
};       

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Physiological parameters ------------------------------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Body mass (kg)
BDM = 70;

# Total blood flow scaling coefficient to body mass (Unit: L/h/kg)
sc_F_total = 15;

# Fractions of total blood flow going to tissues (ref Perdaems 2010)
f_Flow_stom   = 0.024;
f_Flow_duod   = 0.016;
f_Flow_jeju   = 0.056;
f_Flow_ileum  = 0.033;
f_Flow_cecum  = 0.006;
f_Flow_colon  = 0.038;
f_Flow_liver  = 0.250;
f_Flow_kidney = 0.210;
f_Flow_body   = 0.540;


# Tissue fractions of body mass (ref Perdaems 2010)
f_BDM_stom   = 0.0021;
f_BDM_duod   = 0.0003;
f_BDM_jeju   = 0.0009;
f_BDM_ileum  = 0.0006;
f_BDM_cecum  = 0.0005;
f_BDM_colon  = 0.0048;
f_BDM_liver  = 0.0243;
f_BDM_kidney = 0.0096;
f_BDM_body   = 0.8730;
f_BDM_blood  = 0.0650;

# Lumina as fractions of body mass (ref Perdaems 2010) # not used
f_BDM_stom_lu  = 0.0036;
f_BDM_duod_lu  = 0.0003;
f_BDM_jeju_lu  = 0.0023;
f_BDM_ileum_lu = 0.0032;
f_BDM_cecum_lu = 0.0001;
f_BDM_colon_lu = 0.0051;

# Lengths of gi tract segments (decimeters, dm) for SA calculation
Length_stom  = 2.83;
Length_duod  = 1.41;
Length_jeju  = 11.68;
Length_ileum = 17.52;
Length_cecum = 1.7;
Length_colon = 11.0;

# Radii of gi tract segments (dm) for SA calculation
Radius_stom  = 0.967;
Radius_duod  = 0.153;
Radius_jeju  = 0.137;
Radius_ileum = 0.098;
Radius_cecum = 0.35;
Radius_colon = 0.25;

# Transit half-lives in lumina (ref Perdaems 2010) (hours) for Kt calculation
T12_stom_lu  = 0.25;
T12_duod_lu  = 0.25;
T12_jeju_lu  = 1.02;
T12_ileum_lu = 2.04;
T12_cecum_lu = 4.55;
T12_colon_lu = 13.5;

#-------------------------------------------------------#
# pH of luminal contents (ref Perdaems 2010)
#pH_stom  = 1.7;
#pH_duod  = 6;
#pH_jeju  = 6.5;
#pH_ileum = 7.4;
#pH_cecum = 5.9;
#pH_colon = 7;
#-------------------------------------------------------#

# Microsomal proteins (mg / g of tissue)
MicroProt_stom    = 0;     
MicroProt_duod    = 18;    # Paine et al. The Journal of Pharmacology and Experimental Therapeutics 1997; 283: 1552-1562.
MicroProt_jeju    = 25;
MicroProt_ileum   = 24;
MicroProt_cecum   = 0.0;
MicroProt_colon   = 0.0;
MicroProt_liver   = 45;    # Houston et al. Toxicology in Vitro 2012; 26: 1265-1271.
MicroProt_kidney  = 13.6;  # Scotcher et al. Drug Metab Dispos. 2017; 45(5): 556?V568.

# G.i. tract epithelial thickness (dm)
H_ep = 3.0E-4; 

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Substance- and formulation specific parameters --------------------------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Molecular mass (g/mol)
MM = 239.74;

#---------------------------------------------------------------------------#
# Acido-basic type: 0 = neutral, 1 = base, 2 = acid, 3 = ampholyte
#AB_type = 2; 

# Ionization constants
#pKa = 8.22;   # acid  equilibrium constant
#pKb = 7.00;   # basic equilibrium constant

# Solute molal volume at normal boiling point (ml/mole) (about twice MM...)
#Mol_vol = 225; # no default value
#---------------------------------------------------------------------------#

#-------------------------Release-related parameter-------------------------#
# Dosage forms: 0/1 switches, mutually exclusive,
# only one on them should be set to 1
G_immediate_d = 0;    # immediate release, dissolved (default)
G_delayed_d   = 0;    # delayed release,   dissolved

# Administration lagtime, if needed (to use in an input function)
Tlag    = 0;
Tlag_SR = 0;
Tlag_ER = 0;

## Release type: 0 = Immediate, 1=Sustained, 2=Extended
R_type = 0;

# Weibull delayed release parameters
Weibull_slope    = 1; 
Weibull_slope_IR = 1;
Weibull_slope_SR = 1;
Weibull_slope_ER = 1; 
Weibull_scale    = 1;
Weibull_scale_IR = 1;
Weibull_scale_SR = 1;
Weibull_scale_ER = 1;
Weibull_lag      = 0;     
Weibull_lag_IR   = 0; 
Weibull_lag_SR   = 0; 
Weibull_lag_ER   = 0; 


# Absorption on(1)/off(0) switches
f_Abs_stom  = 1;
f_Abs_duod  = 1;
f_Abs_jeju  = 1;
f_Abs_ileum = 1;
f_Abs_cecum = 1;
f_Abs_colon = 1;

# Effective permeability of g.i. tract epithelia (dm/hr)
Peff = 0.1;
Peff_ratio_ivive = 1;
Peff_ratio_stom_jeju = 1;
Peff_ratio_duod_jeju = 0.67613;
Peff_ratio_jeju_jeju = 1;
Peff_ratio_ileum_jeju = 0.912668;
Peff_ratio_colon_jeju = 0.727175246; # using rm. outlier one

Peff_ratio_stom_colon = 1;
Peff_ratio_duod_colon = 1.58;# using rm. outlier one
Peff_ratio_jeju_colon = 11.03;# using rm. outlier one
Peff_ratio_ileum_colon = 5.46;# using rm. outlier one
Peff_ratio_colon_colon = 1;

s_jeju_ratio = 1;


# Excretion over absorption rate constant ratios
Ke_over_a_epit = 1E-9; # between lumen and epithelium
Ke_over_a_tiss = 1E-9; # between epithelium and underlying wall tissue

# GI tract apical efflux Vmax
Vmax_eff_stom  = 1E-9; 
Vmax_eff_duod  = 1E-9; 
Vmax_eff_jeju  = 1E-9; 
Vmax_eff_ileum = 1E-9; 
Vmax_eff_cecum = 1E-9; 
Vmax_eff_colon = 1E-9; 
Vmax_eff_liver = 1E-9; 

# GI tract apical influx Vmax
Vmax_inf_stom  = 1E-9; 
Vmax_inf_duod  = 1E-9; 
Vmax_inf_jeju  = 1E-9; 
Vmax_inf_ileum = 1E-9; 
Vmax_inf_cecum = 1E-9; 
Vmax_inf_colon = 1E-9; 
Vmax_inf_liver = 1E-9; 

# GI tract apical efflux Km
Km_eff = 1;

# GI tract apical influx Km
Km_inf = 1; 

# Plasma / blood concentration ratio
Ratio_BP = 0.82;

# Fractions unbound
Fu_plasma  = 0.16;  # fraction unbound in plasma
Fu_stom    = 0.16;  # etc.
Fu_duod    = 0.16; 
Fu_jeju    = 0.16; 
Fu_ileum   = 0.16; 
Fu_cecum   = 0.16; 
Fu_colon   = 0.16; 
Fu_liver   = 0.16;
Fu_kidney  = 0.16;  # add for new acat+pbpk model
Fu_body    = 0.16;  # add for new acat+pbpk model

Fu_vitro_stom   = 0.16;  # in stomach in vitro metabolic system (e.g. microsomes)
Fu_vitro_duod   = 0.16;  # etc.
Fu_vitro_jeju   = 0.16; 
Fu_vitro_ileum  = 0.16; 
Fu_vitro_cecum  = 0.16; 
Fu_vitro_colon  = 0.16; 
Fu_vitro_liver  = 0.16;  # add for new acat+pbpk model
Fu_vitro_kidney = 0.16;  # add for new acat+pbpk model

# Unbound tissue / unbound blood partition coefficients, equal to partition coefficients
Kpuu_stom   = 1; 
Kpuu_duod   = 1; 
Kpuu_jeju   = 1; 
Kpuu_ileum  = 1; 
Kpuu_cecum  = 1; 
Kpuu_colon  = 1; 
Kpuu_liver  = 1;
Kpuu_kidney = 1;
Kpuu_body   = 1; 

# Volumes (L) comment for 
#V_central; 
#V_periph; 

# Volumes (L/kg)
#V_central_LKg = 15;

# Transfer rate constants between central and peripheral compartments (1/h)
#Kc2p = 0.1;
#Kp2c = 0.04;

# Metabolism Michaelis-Menten Vmax (micromol/min/mg microsomal proteins)
Vmax_met_vitro_intestine = 2.6E-5;
Vmax_met_vitro_liver     = 1E-4;
Vmax_met_vitro_kidney    = 0;

# Metabolism Michaelis-Menten Km (microM)
Km_met_vitro_intestine = 573.4;
Km_met_vitro_liver     = 265.7;
Km_met_vitro_kidney    = 1E-9;

# Clearance rate of kidney related parameter
GFR = 7.2; # 120 ml/min/1.73 m2 = 7.2 L/h (https://www.kidney.org/kidneydisease/siemens_hcp_gfr ; https://medlineplus.gov/ency/article/007305.htm)
ETS = 0;
f_reabs = 0;


# Elimination rate constant from central (1/h)
Kelim = 1E-9;

# parameter for calculating the Css
percent_abs;
Oral_dose_rate_Css;

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Scaled physiological G.I. tract parameters, computed in Initiali --------
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Blood flows
F_total;

# Volumes (L)
V_stom;
V_duod;
V_jeju;
V_ileum;
V_cecum;
V_colon;
V_liver;  # add for new acat+pbpk model
V_kidney; # add for new acat+pbpk model
V_body;   # add for new acat+pbpk model
V_blood;  # add for new acat+pbpk model *(not sure for new acat+pbpk model)*

# Tissue volumes in gi tract
V_stom_w;
V_duod_w;
V_jeju_w;
V_ileum_w;
V_cecum_w;
V_colon_w;

# Luminal volumes in gi tract
V_stom_lu;
V_colon_lu;
V_duod_lu;
V_jeju_lu;
V_ileum_lu;
V_cecum_lu;

# Epithelial volumes in gi tract
V_stom_ep;
V_duod_ep;
V_jeju_ep;
V_ileum_ep;
V_cecum_ep;
V_colon_ep;

# Epithelial surface area in gi tract (dm^2)
SA_stom;
SA_duod;
SA_jeju;
SA_ileum;
SA_cecum;
SA_colon;

# Intestinal transit rates
Kt_stom;
Kt_duod;
Kt_jeju;
Kt_ileum;
Kt_cecum;
Kt_colon;

# Blood flows
Flow_portvein;
Flow_art_liv;
Flow_liver;
Flow_stom;
Flow_duod;
Flow_jeju;
Flow_ileum;
Flow_cecum;
Flow_colon;
Flow_kidney; # add for new acat+pbpk model
Flow_body;   # add for new acat+pbpk model

# GI tract absorption flows
Ka_stom;
Ka_duod;
Ka_jeju;
Ka_ileum;
Ka_cecum;
Ka_colon;

# Fraction unbound in blood
Fu_blood;

# In vivo GI tract and liver Vmax for metabolism
Vmax_met_stom;
Vmax_met_duod;
Vmax_met_jeju;
Vmax_met_ileum;
Vmax_met_cecum;
Vmax_met_colon;
Vmax_met_liver;
Vmax_met_kidney; # add for new acat+pbpk model

# In vivo Km for metabolism
Km_met_intestine;
Km_met_liver;
Km_met_kidney; # add for new acat+pbpk model

CL_kidney; # add for new acat+pbpk model

# Population mean *(not do any revision for new acat+pbpk model)*
M_T12_stom_lu;
M_Peff;
M_Fu_plasma;
M_Fu_vitro_liver;
M_Kpuu_liver;
M_Vmax_met_vitro_liver;
M_V_central_LKg;
M_Kc2p;
M_Kp2c;

M_Weibull_slope_IR;
M_Weibull_scale_IR;
M_Weibull_slope_SR;
M_Weibull_scale_SR;
M_Weibull_slope_ER;
M_Weibull_scale_ER;

# Population variance *(not do any revision for new acat+pbpk model)*
## Inter-individuals
Vr_T12_stom_lu;
Vr_Peff;
Vr_Fu_plasma;
Vr_Fu_vitro_liver;
Vr_Kpuu_liver;
Vr_Vmax_met_vitro_liver;
Vr_V_central_LKg;
Vr_Kc2p;
Vr_Kp2c;

Vr_Weibull_slope_IR;
Vr_Weibull_scale_IR;
Vr_Weibull_slope_SR;
Vr_Weibull_scale_SR;
Vr_Weibull_slope_ER;
Vr_Weibull_scale_ER;

## Intra-individuals *(not do any revision for new acat+pbpk model)*
Va_T12_stom_lu;
Va_Peff;
Va_Fu_plasma;
Va_Fu_vitro_liver;
Va_Kpuu_liver;
Va_Vmax_met_vitro_liver;
Va_V_central_LKg;
Va_Kc2p;
Va_Kp2c;

Va_Weibull_slope_IR;
Va_Weibull_scale_IR;
Va_Weibull_slope_SR;
Va_Weibull_scale_SR;
Va_Weibull_slope_ER;
Va_Weibull_scale_ER;

# Measurement error variances for output *(not do any revision for new acat+pbpk model)*
Ve_C_central;

Initialize { 
  
#  V_central = V_central_LKg*BDM;  *(not sure for new acat+pbpk model)*
#  V_periph = V_central*Kc2p/Kp2c; *(not sure for new acat+pbpk model)*
  
  Weibull_slope = (R_type == 1 ? Weibull_slope_SR : (R_type == 2 ? Weibull_slope_ER : Weibull_slope_IR));
  Weibull_scale = (R_type == 1 ? Weibull_scale_SR : (R_type == 2 ? Weibull_scale_ER : Weibull_scale_IR));
  
  # Total blood flow
  F_total = sc_F_total * pow(BDM, 0.75);
  
  V_liver  = BDM * f_BDM_liver;
  V_kidney = BDM * f_BDM_kidney; # add for new acat+pbpk model
  V_body   = BDM * f_BDM_body;   # add for new acat+pbpk model
  V_blood  = BDM * f_BDM_blood;  # add for new acat+pbpk model *(not sure for new acat+pbpk model)*
  
  # Volumes of gi tract tissues
  V_stom_w   = BDM * f_BDM_stom;
  V_duod_w   = BDM * f_BDM_duod;
  V_jeju_w   = BDM * f_BDM_jeju;
  V_ileum_w  = BDM * f_BDM_ileum;
  V_cecum_w  = BDM * f_BDM_cecum;
  V_colon_w  = BDM * f_BDM_colon;
  
  # Blood flows
  Flow_stom      = F_total * f_Flow_stom;
  Flow_duod      = F_total * f_Flow_duod;
  Flow_jeju      = F_total * f_Flow_jeju;
  Flow_ileum     = F_total * f_Flow_ileum;
  Flow_cecum     = F_total * f_Flow_cecum;
  Flow_colon     = F_total * f_Flow_colon;
  Flow_portvein  = Flow_stom  + Flow_duod  + Flow_jeju + Flow_ileum + Flow_cecum + Flow_colon;
  Flow_art_liv   = F_total * f_Flow_liver - Flow_portvein;
  Flow_liver     = F_total * f_Flow_liver;
  Flow_kidney    = F_total * f_Flow_kidney;
  Flow_body      = F_total * f_Flow_body;
  
  # Epithelial surface areas
  SA_stom   = Length_stom  * 2 * 3.1416 * Radius_stom;
  SA_duod   = Length_duod  * 2 * 3.1416 * Radius_duod;
  SA_jeju   = Length_jeju  * 2 * 3.1416 * Radius_jeju;
  SA_ileum  = Length_ileum * 2 * 3.1416 * Radius_ileum;
  SA_cecum  = Length_cecum * 2 * 3.1416 * Radius_cecum;
  SA_colon  = Length_colon * 2 * 3.1416 * Radius_colon;
  
  # Luminal volumes
  V_stom_lu  = 3.14 * Radius_stom * Radius_stom * Length_stom;
  V_duod_lu  = 3.14 * Radius_duod * Radius_duod * Length_duod;
  V_jeju_lu  = 3.14 * Radius_jeju * Radius_jeju * Length_jeju;
  V_ileum_lu = 3.14 * Radius_ileum * Radius_ileum * Length_ileum;
  V_cecum_lu = 3.14 * Radius_cecum * Radius_cecum * Length_cecum;
  V_colon_lu = 3.14 * Radius_colon * Radius_colon * Length_colon;
  
  # Intestinal transit rates
  Kt_stom  = (log(2.0) * V_stom_lu  / T12_stom_lu);
  Kt_duod  = (log(2.0) * V_duod_lu  / T12_duod_lu);
  Kt_jeju  = (log(2.0) * V_jeju_lu  / T12_jeju_lu);
  Kt_ileum = (log(2.0) * V_ileum_lu / T12_ileum_lu);
  Kt_cecum = (log(2.0) * V_cecum_lu / T12_cecum_lu);
  Kt_colon = (log(2.0) * V_colon_lu / T12_colon_lu);
  
  # Epithelial volumes
  V_stom_ep     = H_ep * SA_stom;
  V_duod_ep     = H_ep * SA_duod;
  V_jeju_ep     = H_ep * SA_jeju;
  V_ileum_ep    = H_ep * SA_ileum;
  V_cecum_ep    = H_ep * SA_cecum;
  V_colon_ep    = H_ep * SA_colon;
  
  # Fraction unbound in blood
  Fu_blood = Fu_plasma / Ratio_BP;
  
  # Metabolic parameters, scaled from in vitro values; micromol/h
  Vmax_met_stom   = Vmax_met_vitro_intestine * 60 * MicroProt_stom  * V_stom_ep  * 1000;
  Vmax_met_duod   = Vmax_met_vitro_intestine * 60 * MicroProt_duod  * V_duod_ep  * 1000;
  Vmax_met_jeju   = Vmax_met_vitro_intestine * 60 * MicroProt_jeju  * V_jeju_ep  * 1000;
  Vmax_met_ileum  = Vmax_met_vitro_intestine * 60 * MicroProt_ileum * V_ileum_ep * 1000;
  Vmax_met_cecum  = Vmax_met_vitro_intestine * 60 * MicroProt_cecum * V_cecum_ep * 1000;
  Vmax_met_colon  = Vmax_met_vitro_intestine * 60 * MicroProt_colon * V_colon_ep * 1000;
  Vmax_met_liver  = Vmax_met_vitro_liver * 60 * MicroProt_liver * V_liver * 1000;
  Vmax_met_kidney = Vmax_met_vitro_kidney * 60 * MicroProt_kidney * V_kidney * 1000;

  Km_met_intestine = Km_met_vitro_intestine;
  Km_met_liver = Km_met_vitro_liver;
  Km_met_kidney = Km_met_vitro_kidney;

  # Clearance rate of kidney
  CL_kidney = Flow_kidney * (Fu_plasma * (GFR/Flow_kidney) + (1 - Fu_plasma * (GFR/Flow_kidney)) * ETS) * (1 - f_reabs);
  
  
  # GI tract absorption flows
  Ka_stom  = (s_jeju_ratio == 1 ? Peff * Peff_ratio_stom_jeju * SA_stom  * f_Abs_stom/Peff_ratio_ivive : Peff * Peff_ratio_stom_colon * SA_stom  * f_Abs_stom);
  Ka_duod  = (s_jeju_ratio == 1 ? Peff * Peff_ratio_duod_jeju * SA_duod  * f_Abs_duod/Peff_ratio_ivive : Peff * Peff_ratio_duod_colon * SA_duod  * f_Abs_duod);
  Ka_jeju  = (s_jeju_ratio == 1 ? Peff * Peff_ratio_jeju_jeju * SA_jeju  * f_Abs_jeju/Peff_ratio_ivive : Peff * Peff_ratio_jeju_colon * SA_jeju  * f_Abs_jeju);
  Ka_ileum = (s_jeju_ratio == 1 ? Peff * Peff_ratio_ileum_jeju * SA_ileum * f_Abs_ileum/Peff_ratio_ivive : Peff * Peff_ratio_ileum_colon * SA_ileum * f_Abs_ileum);
  Ka_cecum = (s_jeju_ratio == 1 ? Peff * Peff_ratio_colon_jeju * SA_cecum * f_Abs_cecum/Peff_ratio_ivive : Peff * Peff_ratio_colon_colon * SA_cecum * f_Abs_cecum);
  Ka_colon = (s_jeju_ratio == 1 ? Peff * Peff_ratio_colon_jeju * SA_colon * f_Abs_colon/Peff_ratio_ivive : Peff * Peff_ratio_colon_colon * SA_colon * f_Abs_colon);
  
}


Dynamics { 
  
  # Delayed release modeling
  K_release = (Weibull_slope/Weibull_scale) * pow(t/Weibull_scale, Weibull_slope-1);
  Release_rate = Q_to_release * K_release;
  
  # Concentrations dissolved in gi tract lumina
  C_stom_lu_d  = Q_stom_lu_d  / V_stom_lu;
  C_duod_lu_d  = Q_duod_lu_d  / V_duod_lu;
  C_jeju_lu_d  = Q_jeju_lu_d  / V_jeju_lu;
  C_ileum_lu_d = Q_ileum_lu_d / V_ileum_lu;
  C_cecum_lu_d = Q_cecum_lu_d / V_cecum_lu;
  C_colon_lu_d = Q_colon_lu_d / V_colon_lu;
  
  # Concentrations in gi tract epithelia
  C_stom_ep  = Q_stom_ep  / V_stom_ep;
  C_duod_ep  = Q_duod_ep  / V_duod_ep;
  C_jeju_ep  = Q_jeju_ep  / V_jeju_ep;
  C_ileum_ep = Q_ileum_ep / V_ileum_ep;
  C_cecum_ep = Q_cecum_ep / V_cecum_ep;
  C_colon_ep = Q_colon_ep / V_colon_ep;
  
  # Concentrations unbound in gi tract epithelia
  Cu_stom_ep  = C_stom_ep  * Fu_stom;
  Cu_duod_ep  = C_duod_ep  * Fu_duod;
  Cu_jeju_ep  = C_jeju_ep  * Fu_jeju;
  Cu_ileum_ep = C_ileum_ep * Fu_ileum;
  Cu_cecum_ep = C_cecum_ep * Fu_cecum;
  Cu_colon_ep = C_colon_ep * Fu_colon;
  
  # Concentrations in gi tract walls
  C_stom_w  = Q_stom_w  / V_stom_w;
  C_duod_w  = Q_duod_w  / V_duod_w;
  C_jeju_w  = Q_jeju_w  / V_jeju_w;
  C_ileum_w = Q_ileum_w / V_ileum_w;
  C_cecum_w = Q_cecum_w / V_cecum_w;
  C_colon_w = Q_colon_w / V_colon_w;

  C_liver   = (Q_liver  > 0 ? Q_liver   / V_liver  : 1e-10); # add for new acat+pbpk model
  C_kidney  = (Q_kidney > 0 ? Q_kidney  / V_kidney : 1e-10); # add for new acat+pbpk model
  C_body    = (Q_body   > 0 ? Q_body    / V_body   : 1e-10); # add for new acat+pbpk model
  
  # Concentrations unbound in gi tract walls
  Cu_stom_w  = C_stom_w  * Fu_stom;
  Cu_duod_w  = C_duod_w  * Fu_duod;
  Cu_jeju_w  = C_jeju_w  * Fu_jeju;
  Cu_ileum_w = C_ileum_w * Fu_ileum;
  Cu_cecum_w = C_cecum_w * Fu_cecum;
  Cu_colon_w = C_colon_w * Fu_colon;
  
  # Concentration unbound in organ
  Cu_liver  = C_liver  * Fu_liver;
  Cu_kidney = C_kidney * Fu_kidney;
  Cu_body   = C_body   * Fu_body;
  Cu_blood  = C_blood  * Fu_blood;
  
  # Concentrations unbound in blood at gi tract segments exit
  Cu_stom_b  = Cu_stom_w  / Kpuu_stom;
  Cu_duod_b  = Cu_duod_w  / Kpuu_duod;
  Cu_jeju_b  = Cu_jeju_w  / Kpuu_jeju;
  Cu_ileum_b = Cu_ileum_w / Kpuu_ileum;
  Cu_cecum_b = Cu_cecum_w / Kpuu_cecum;
  Cu_colon_b = Cu_colon_w / Kpuu_colon;
  
  # Concentration unbound in blood at organ exit
  Cu_liver_b  = Cu_liver  / Kpuu_liver;
  Cu_kidney_b = Cu_kidney / Kpuu_kidney;
  Cu_body_b   = Cu_body   / Kpuu_body;
  
  # Concentrations in blood at gi tract segments exit
  C_stom_b  = Cu_stom_b  / Fu_blood;
  C_duod_b  = Cu_duod_b  / Fu_blood;
  C_jeju_b  = Cu_jeju_b  / Fu_blood;
  C_ileum_b = Cu_ileum_b / Fu_blood;
  C_cecum_b = Cu_cecum_b / Fu_blood;
  C_colon_b = Cu_colon_b / Fu_blood;
  
  # Concentration in blood at organ exit (venous blood concentration leaving organ)
  C_liver_b  = Cu_liver_b  / Fu_blood;
  C_kidney_b = Cu_kidney_b / Fu_blood;
  C_body_b   = Cu_body_b   / Fu_blood;
  
  # Concentration in blood and plasma
  C_plasma   = C_blood / Ratio_BP;
  C_blood    = (Q_blood > 0 ? Q_blood / V_blood : 1e-10);

  
  # Transfers from lumen to lumen or feces (intestinal transit) (dissolved)
  Rate_stl2dul = Kt_stom  * C_stom_lu_d;
  Rate_dul2jel = Kt_duod  * C_duod_lu_d;
  Rate_jel2ill = Kt_jeju  * C_jeju_lu_d;
  Rate_ill2cel = Kt_ileum * C_ileum_lu_d;
  Rate_cel2col = Kt_cecum * C_cecum_lu_d;
  Rate_col2fel = Kt_colon * C_colon_lu_d;

  
  # Transfers from lumina to epithelia for dissolved form: pasive, active
  # influx and active efflux
  Rate_stl2ste = Ka_stom  * (C_stom_lu_d  - Ke_over_a_epit * Cu_stom_ep) +
    Vmax_inf_stom * C_stom_lu_d / (Km_inf + C_stom_lu_d) -
    Vmax_eff_stom * Cu_stom_ep  / (Km_eff + Cu_stom_ep);
  Rate_dul2due = Ka_duod  * (C_duod_lu_d  - Ke_over_a_epit * Cu_duod_ep) +
    Vmax_inf_duod * C_duod_lu_d / (Km_inf + C_duod_lu_d) -
    Vmax_eff_duod * Cu_duod_ep  / (Km_eff + Cu_duod_ep);
  Rate_jel2jee = Ka_jeju  * (C_jeju_lu_d  - Ke_over_a_epit * Cu_jeju_ep) +
    Vmax_inf_jeju * C_jeju_lu_d / (Km_inf + C_jeju_lu_d) -
    Vmax_eff_jeju * Cu_jeju_ep  / (Km_eff + Cu_jeju_ep);
  Rate_ill2ile = Ka_ileum * (C_ileum_lu_d - Ke_over_a_epit * Cu_ileum_ep) +
    Vmax_inf_ileum * C_ileum_lu_d / (Km_inf + C_ileum_lu_d) -
    Vmax_eff_ileum * Cu_ileum_ep  / (Km_eff + Cu_ileum_ep);
  Rate_cel2cee = Ka_cecum * (C_cecum_lu_d - Ke_over_a_epit * Cu_cecum_ep) +
    Vmax_inf_cecum * C_cecum_lu_d / (Km_inf + C_cecum_lu_d) -
    Vmax_eff_cecum * Cu_cecum_ep  / (Km_eff + Cu_cecum_ep);
  Rate_col2coe = Ka_colon * (C_colon_lu_d - Ke_over_a_epit * Cu_colon_ep) +
    Vmax_inf_colon * C_colon_lu_d / (Km_inf + C_colon_lu_d) -
    Vmax_eff_colon * Cu_colon_ep  / (Km_eff + Cu_colon_ep);
  
  Rate_blo2liv = Vmax_inf_liver * Cu_liver_b / (Km_inf + Cu_liver_b) -
    Vmax_eff_liver * Cu_liver   / (Km_eff + Cu_liver);
  
  # Transfers from epithelia to wall tissues
  Rate_ste2stw = Ka_stom  * (Cu_stom_ep  - Ke_over_a_tiss * Cu_stom_w);
  Rate_due2duw = Ka_duod  * (Cu_duod_ep  - Ke_over_a_tiss * Cu_duod_w);
  Rate_jee2jew = Ka_jeju  * (Cu_jeju_ep  - Ke_over_a_tiss * Cu_jeju_w);
  Rate_ile2ilw = Ka_ileum * (Cu_ileum_ep - Ke_over_a_tiss * Cu_ileum_w);
  Rate_cee2cew = Ka_cecum * (Cu_cecum_ep - Ke_over_a_tiss * Cu_cecum_w);
  Rate_coe2cow = Ka_colon * (Cu_colon_ep - Ke_over_a_tiss * Cu_colon_w);
  
  # Transfers from tissues wall to portal vein
  Rate_stw2b = Flow_stom  * C_stom_b;
  Rate_duw2b = Flow_duod  * C_duod_b;
  Rate_jew2b = Flow_jeju  * C_jeju_b;
  Rate_ilw2b = Flow_ileum * C_ileum_b;
  Rate_cew2b = Flow_cecum * C_cecum_b;
  Rate_cow2b = Flow_colon * C_colon_b;
  
  # Portal rate in
  RateIn_portvein = Rate_stw2b + Rate_duw2b + Rate_jew2b +
    Rate_ilw2b + Rate_cew2b + Rate_cow2b;
  
  # Differential equations
  
  # Quantity released to the stomach in case of delayed release
  dt (Q_released) = Release_rate;
  
  # Quantity to be released in the stomach in case of linear delayed release
  dt (Q_to_release) = - Release_rate;
  
  # Quantities absorbed
  dt (Q_absorb_stom)  = Rate_stl2ste;
  dt (Q_absorb_duod)  = Rate_dul2due;
  dt (Q_absorb_jeju)  = Rate_jel2jee;
  dt (Q_absorb_ileum) = Rate_ill2ile;
  dt (Q_absorb_cecum) = Rate_cel2cee;
  dt (Q_absorb_colon) = Rate_col2coe;
  
  # Quantity reaching the portal vein
  dt (Q_absorb_pv) = RateIn_portvein;
  
  # Elimination and metabolism
  
#  dt (Q_elim_central) = Kelim * Q_central;
  
  dt (Q_met_stom)  = Vmax_met_stom  * Cu_stom_ep /
    (Km_met_intestine * Fu_vitro_stom + Cu_stom_ep);
  
  dt (Q_met_duod)  = Vmax_met_duod  * Cu_duod_ep /
    (Km_met_intestine * Fu_vitro_duod + Cu_duod_ep);
  
  dt (Q_met_jeju)  = Vmax_met_jeju  * Cu_jeju_ep /
    (Km_met_intestine * Fu_vitro_jeju + Cu_jeju_ep);
  
  dt (Q_met_ileum) = Vmax_met_ileum * Cu_ileum_ep /
    (Km_met_intestine * Fu_vitro_ileum + Cu_ileum_ep);
  
  dt (Q_met_cecum) = Vmax_met_cecum * Cu_cecum_ep /
    (Km_met_intestine * Fu_vitro_cecum + Cu_cecum_ep);
  
  dt (Q_met_colon) = Vmax_met_colon * Cu_colon_ep /
    (Km_met_intestine * Fu_vitro_colon + Cu_colon_ep);
  
  dt (Q_met_liver) = Vmax_met_liver * Cu_liver /
    (Km_met_liver * Fu_vitro_liver + Cu_liver);
  
  dt (Q_met_kidney) = Vmax_met_kidney * Cu_kidney /
    (Km_met_kidney * Fu_vitro_kidney + Cu_kidney); # add for new acat+pbpk model
  
  dt (Q_feces_d) = Rate_col2fel;

  
  # Distributions
  
#  dt(Q_periph)  = Kc2p * Q_central - Kp2c * Q_periph;
#  dt(Q_central) = IV_dose_rate + Q_out_liver - Rate_blo2liv - (Flow_portvein + Flow_art_liv) * C_central - dt(Q_periph) - dt(Q_elim_central);  
  
  # Liver
  Q_out_liver   = (Flow_portvein + Flow_art_liv) * C_liver_b;
  
  dt(Q_liver)   = RateIn_portvein + Flow_art_liv * C_blood - Q_out_liver + Rate_blo2liv - dt(Q_met_liver);
 
  # kidney
  Q_out_kidney  = Flow_kidney * C_kidney_b;
  dt(Q_urine)    = C_plasma * CL_kidney;
  
  dt(Q_kidney)  = Flow_kidney * C_blood - Q_out_kidney - dt(Q_met_kidney) - dt(Q_urine);
  
  # Body
  Q_out_body    = Flow_body * C_body_b;
  
  dt(Q_body)    = Flow_body * C_blood - Q_out_body;
  
  # Blood
  dt(Q_blood)   = Q_out_liver + Q_out_kidney + Q_out_body - C_blood * F_total - Rate_blo2liv;
  
  
  # Stomach
  dt(Q_stom_lu_d) = (G_immediate_d > 0.5 ? Oral_dose_rate : 
                       (G_delayed_d > 0.5 ? Release_rate : 0.0)) - Rate_stl2dul - Rate_stl2ste;

  
  dt(Q_stom_ep)   = Rate_stl2ste - Rate_ste2stw - dt (Q_met_stom);
  
  dt(Q_stom_w)    = Flow_stom * C_blood + Rate_ste2stw - Rate_stw2b;
  
  # Duodenum
  dt(Q_duod_lu_d) = Rate_stl2dul  - Rate_dul2jel - Rate_dul2due;
  
  
  dt(Q_duod_ep)   = Rate_dul2due - Rate_due2duw - dt (Q_met_duod);
  
  dt(Q_duod_w)    = Flow_duod * C_blood + Rate_due2duw - Rate_duw2b;
  
  # Jejunum
  dt(Q_jeju_lu_d) = Rate_dul2jel  - Rate_jel2ill - Rate_jel2jee;
  
  
  dt(Q_jeju_ep)   = Rate_jel2jee - Rate_jee2jew - dt (Q_met_jeju);
  
  dt(Q_jeju_w)    = Flow_jeju * C_blood + Rate_jee2jew - Rate_jew2b;
  
  # Ileum
  dt(Q_ileum_lu_d) = Rate_jel2ill  - Rate_ill2cel - Rate_ill2ile;
  
  
  dt(Q_ileum_ep)   = Rate_ill2ile - Rate_ile2ilw - dt (Q_met_ileum);
  
  dt(Q_ileum_w)    = Flow_ileum * C_blood + Rate_ile2ilw - Rate_ilw2b;
  
  # Cecum
  dt(Q_cecum_lu_d) = Rate_ill2cel  - Rate_cel2col - Rate_cel2cee;
  
  
  dt(Q_cecum_ep)   = Rate_cel2cee - Rate_cee2cew - dt (Q_met_cecum);
  
  dt(Q_cecum_w)    = Flow_cecum * C_blood + Rate_cee2cew - Rate_cew2b;
  
  # Colon
  dt(Q_colon_lu_d) = Rate_cel2col  - dt (Q_feces_d) - Rate_col2coe;
  
  
  dt(Q_colon_ep)   = Rate_col2coe - Rate_coe2cow - dt (Q_met_colon);
  
  dt(Q_colon_w)    = Flow_colon * C_blood + Rate_coe2cow - Rate_cow2b;
  

  C_blood_ngml = C_blood * MM ;
  
#  dt(AUC_blood) = C_blood_ngml;
  dt(AUC_blood) = C_blood;
  
  # caculation for check absorption and ivive equation

  CL_int = (Vmax_met_liver / (Km_met_liver * Fu_vitro_liver)) * Kpuu_liver;
  E_pbpk = dt(Q_met_liver) / (RateIn_portvein + Flow_art_liv * C_blood);
  E_equ = Fu_blood * CL_int / (Flow_liver + CL_int * Fu_blood);

  }

CalcOutputs { 
  
  C_blood_ngml = (C_blood_ngml > 0 ? C_blood_ngml : 1e-10); # when C_blood_ngml <= 0, let C_blood_ngml = 1e-10
  lnC_blood_ngml = log(C_blood_ngml);
  
  # Extra quantities and mass balance checking
  
  Q_gi_lu_d = Q_stom_lu_d  + Q_duod_lu_d + Q_jeju_lu_d + Q_ileum_lu_d +
    Q_cecum_lu_d + Q_colon_lu_d; #equ 28
  
  Q_gi_ep   = Q_stom_ep  + Q_duod_ep + Q_jeju_ep + Q_ileum_ep +
    Q_cecum_ep + Q_colon_ep; #equ 29
  
  Q_gi_w    = Q_stom_w  + Q_duod_w + Q_jeju_w + Q_ileum_w +
    Q_cecum_w + Q_colon_w; #equ 30
  
  Q_absorb  = Q_absorb_stom  + Q_absorb_duod  +
    Q_absorb_jeju  + Q_absorb_ileum +
    Q_absorb_cecum + Q_absorb_colon; #equ 31
  
  Q_met_gi  = Q_met_stom  + Q_met_duod  + Q_met_jeju +
    Q_met_ileum + Q_met_cecum + Q_met_colon;
  
  Q_elim_gi = Q_met_gi + Q_feces_d; #equ 32
  
  Q_elim    = Q_met_liver + Q_met_kidney + Q_urine + Q_elim_gi;
  
  Q_organ   = Q_blood + Q_body + Q_kidney + Q_liver + Q_gi_lu_d + Q_gi_ep + Q_gi_w;
  
  Q_gut     = Q_gi_lu_d + Q_gi_ep + Q_gi_w;
  
  Q_total   = Q_organ + Q_elim;
  
  F_bio = (1 - ((Q_feces_d + Q_gi_lu_d) / Q_total))*100; #Q_elim_gi -> Q_feces_d
  
  Instant_Ka_gi = (Q_gi_lu_d > 0 ? Q_absorb_pv / Q_gi_lu_d : 0);
  
  C_ss_equ = (Oral_dose_rate * F_bio/100 * (1 - E_equ)) / 
    ((GFR * Fu_blood) + (Flow_liver * E_equ)); # add for new acat + pbpk model

  
}

End.

