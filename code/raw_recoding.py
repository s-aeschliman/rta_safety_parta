import pandas as pd
import numpy as np
import re
import mapping_dicts as md

def encode_util(df, feature):
    dummies = pd.get_dummies(df[[feature]])
    res = pd.concat([df, dummies], axis=1)
    # res = res.drop([feature], axis=1)
    return res

dem_data = pd.read_csv("../raw/wave_8.csv")[["INC4WGTN", "HHVEHN", "FREQ8", "TRNST_LYLTY", "PURP8", "AGEGRN", "GENDRN", "MODE", "MODE8"]]
dem_data["INC4WGTN"] = dem_data["INC4WGTN"].map(md.inc_mapping)
dem_data["HHVEHN"] = dem_data["HHVEHN"].map(md.veh_mapping)
dem_data["FREQ8"] = dem_data["FREQ8"].map(md.freq_mapping)
dem_data["TRNST_LYLTY"] = dem_data["TRNST_LYLTY"].map(md.loyalty_mapping)
dem_data["PURP8"] = dem_data["PURP8"].map(md.purpose_mapping)
print(dem_data["AGEGRN"].unique())
dem_data["AGEGRN"] = dem_data["AGEGRN"].map(md.age_mapping)
print(dem_data["AGEGRN"].unique())

dem_data = encode_util(dem_data, "GENDRN")

reg_mode = re.compile(r'^MODE')     # mode columns
mode_cols = list(filter(reg_mode.search, list(dem_data.columns)))

for c in mode_cols:
        dem_data[c] = dem_data[c].map(md.mode_mapping)
        dem_data = encode_util(dem_data, c)

dem_data.to_csv("../data/recoded_dem_data.csv")

data = pd.read_csv("../raw/wave_8.csv").filter(regex="UNID|_MS_.*_1")

data = data.replace({
    "Less safe": -1,
    "Neutral": 0,
    "More safe": 1
})

data.to_csv("../data/recoded_more_safe.csv")