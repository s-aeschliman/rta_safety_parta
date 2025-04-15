"""
This file contains mappings from the raw survey answer strings to new values,
whether numeric or shorter strings (for cleaner one-hot encoding)

See the data dictionaries for more information

"""
# ---------------------------------------------------- WAVE 6 ---------------------------------------------------

#

#


# ---------------------------------------------------- WAVE 7 ---------------------------------------------------

# Age, income, hhvehs, gender, loyalty, region, mode, purpose: SAME AS WAVE 8

# TODO: ACCD**, FAMIMPACC, EFFACC



effaq_mapping = {"Not at all effective": 1,
                  "Not so effective": 2,
                  "Not sure": 3,
                  "Somewhat effective": 4,
                  "Very effective": 5}

effacc_mapping = {"Not at all effective": 1,
                  "Not so effective": 2,
                  "Not sure": 3,
                  "Somewhat effective": 4,
                  "Very effective": 5}

famimp_mapping = {"Not at all familiar": 1,
                  "Not so familiar": 2,
                  "Not sure": 3,
                  "Somewhat familiar": 4,
                  "Very familiar": 5}

famimpacc_mapping = {"Not at all familiar": 1,
                      "Not so familiar": 2,
                      "Not sure": 3,
                      "Somewhat familiar": 4,
                      "Very familiar": 5}


impyraq_mapping = {"Not sure": "IDK",
                   "Yes": "YES",
                   "No": "NO",
                   "Not applicable": "NA"}

chngsfty_mapping = {"colname": "CHNGSFTY",

                    "Values": {
                        "Worsened to an intolerable level": -2,
                        "Somewhat worsened": -1,
                        "Remained about the same": 0,
                        "Somewhat improved": 1,
                        "Improved significantly": 2
                        }
                    }

trfair_mapping = {"distributed fairly": "FAIR",
                  "distributed unfairly": "UNFAIR",
                  "I don't know": "IDK"
                  }

trsupply_mapping = {"I get about as much transit": "SAME",
                    "I get more transit service": "MORE",
                    "I get less transit service": "LESS",
                    "I don't know": "IDK"}

pay4tr_mapping = {"I pay about the same for transit service": "SAME",
                  "I pay more for transit service than I need t": "MORE",
                  "I pay less for transit service than I need t": "LESS",
                  "I don't know": "IDK"}

famsafty_mapping = {"colname": "FAMSAFTY",

                    "Values": {
                        "Not at all familiar": 1,
                        "Not so familiar": 2,
                        "Somewhat familiar": 3,
                        "Very familiar": 4
                        }
                    }

effsafty_mapping = {"colname": "EFFSAFTY",

                    "Values": {
                        "Not sure": 0,
                        "Not at all effective": 1,
                        "Not so effective": 2,
                        "Somewhat effective": 3,
                        "Very effective": 4
                        }
                    }

wls_mapping = {"I would telecommute more often": 1,
               "Concerns about cleanliness onboard": 1,
               "Change in employment status": 1,
               "Service is not running frequently enough": 1,
               "Change in residential location where transit is not as convenient": 1,
               "Change in workplace location where transit is not as convenient": 1,
               "Concerns about contracting COVID": 1,
               "I need to travel less due to changes in my work schedule": 1,
               "Concerns about personal safety on vehicles": 1,
               "Concerns about personal safety at transit stations/stops": 1,
               "Concerns about unreliable transit travel times": 1,
               "Travel by transit takes too long": 1,
               "Driving for few days a week would not cost as much as commuting daily": 1,
               "Concerns about personal safety while walking to/from transit stations/stops": 1,
               "Transit service is not as reliable as before": 1
               }

eq_mapping = {"the same service to everyone regardless of need": 1,
              "more service to people in need": 1,
              "only as much service as someone pays for": 1,
              "as much service as people use": 1}

purpose_mapping_7 = {"colname": "PURP7",

                     "Values": {
                         "Commuting to/from work": "WORK",
                         "Work related": "WORK_REL",
                         "School": "SCHOOL",
                         "Recreation": "RECREATION",
                         "Visiting family/friends": "FAM_FR",
                         "Shopping": "SHOP",
                         "Medical": "MEDICAL",
                         "Personal": "PERSONAL",
                         "Entertainment": "ENTERTAINMENT",
                         "Eating or drinking out": "FOOD",
                         "Religious": "RELIGIOUS"
                        }
                     }

age_mapping_7 = {"colname": "AGEGR7",

                 "Values": {
                     "Under 25": 1,
                     "25-44": 2,
                     "45-54": 3,
                     "55-64": 4,
                     "65 or Over": 5
                     }
                 }

ind_mapping = {"colname": "INDSTRY7",

               "Values": {
                   "Manufacturing": "MANUFACTURING",
                   "Emergency services": "EMERGENCY",
                   "Healthcare": "HEALTHCARE",
                   "Professional Services": "PROF_SERV",
                   "Construction": "CONSTRUCTION",
                   "Arts and entertainment": "ART_ENT",
                   "Social Services": "SOCIAL",
                   "Financial services": "FINANCE",
                   "Other": "OTHER",
                   "Retail": "RETAIL",
                   "Technology and Telecommunications": "TECH",
                   "Transportation and logistics": "TRANSPORT",
                   "Food service/grocery/agriculture": "FOOD_AG",
                   "Real Estate": "REALTY",
                   "Hospitality": "HOSPITALITY",
                   "Media": "MEDIA",
                   "Utilities": "UTILITIES",
                   "Administrative and Support and Waste Management": "ADMIN"
                    }
               }

avail_mapping = {
    "Yes": 2,
    "Sometimes": 1,
    "No": 0
}

essnwrk_mapping = {
    "Yes": "YES",
    "No": "NO",
    "I don't know": "IDK"
}


return_mapping = {

    "I am already riding near or as much as pre-COVID times": 0,
    "Some time this month": 1,
    "November - December 2022": 2,
    "January - March 2023": 3,
    "April - June 2023": 4,
    "In the second half of 2023": 5,
    "In the first half of 2024": 6,
    "In the second half of 2024": 7,
    "I don't foresee returning to transit regularly": 8

}

wfh_mapping = {"colname": "CANWFH7",

               "Values": {
                   "No": "NO",
                   "Yes": "YES",
                   "Yes, but with limitations": "SOME"
                    }
               }

cr_wfh_freq_mapping = {"colname": "CR_WFHSTAT",

                       "Values": {
                           "Never": 0,
                           "Less than monthly": 1,
                           "1-3 days a month": 2,
                           "1 day a week": 3,
                           "2 days a week": 4,
                           "3 days a week": 5,
                           "4 days a week": 6,
                           "5 days a week": 7,
                           "6-7 days a week": 8
                            }
                       }

prefer_wfh_mapping = {"colname": "PRFR_WFH7",

                      "Values": {
                          "Never": 0,
                          "1-3 days a month": 1,
                          "2 days a week": 2,
                          "3 days a week": 3,
                          "4 days a week": 4,
                          "5 days a week": 5,
                          "6 days a week": 6,
                          "7 days a week": 7
                        }
                      }

pc_freq_mapping = {"colname": "PSCVDTRFQ",

                   "Values": {
                       "Same as before COVID-19": "SAME",
                       "Less than before COVID-19": "LESS",
                       "More than before COVID-19": "MORE"
                        }
                   }

empl_wfh_mapping = {"colname": "EMPLCY_WFH7",

                    "Values": {"Not applicable": -1,
                                "No limitations": 0,
                                "Work at the workplace one to three days per month": 1,
                                "Work at the workplace at least a day per week": 2,
                                "Work at the workplace at least two days per week": 3,
                                "Work at the workplace at least three days per week": 4,
                                "Work at the workplace at least four days per week": 5,
                                "Work at the workplace five or more days a week": 6,
                                "Work at the workplace at all times with no exceptions": 7
                               }
                    }

trbar_mapping = {"I can't find employment near transit services that I have access to.": 1,
                 "I can't afford housing near transit services that I can take.": 1,
                 "Transit takes too long to travel to my daily activities.": 1,
                 "Transit is not reliable enough for me to ride regularly.": 1,
                 "Transit service is too infrequent for me to travel to my daily activities.": 1,
                 "Transit service is not available when I need to travel.": 1,
                 "I don't feel secure riding transit when I need to travel.": 1,
                 "I can't afford to ride transit regularly.": 1,
                 "Transit is not available for my destinations.": 1,
                 "Transit is not available where I live.": 1,
                 "I don't feel secure riding transit where I need to travel.": 1,
                 "Vehicles are not comfortable.": 1,
                 "Vehicles are too crowded.": 1,
                 "Nothing, I am using transit as much as I could.": 1,
                 "Other barriers": 1
                 }


# ---------------------------------------------------- WAVE 8 ---------------------------------------------------

m_safety_mapping = {"Less safe": 1,
                    "Neutral": 2,
                    "More safe": 3}

l_safety_mapping = {"Much less safe": 1,
                    "Somewhat less safe": 2,
                    "Neutral/Not concerned": 3}

exp_mapping = {"I have heard about this through word of mouth or social media": 1,
               "I have heard about this through traditional news media": 1,
               "I have witnessed this": 1,
               "Have not witnessed or Don't Know": 1}

age_mapping = {"Under 25": 1,
               "25-44": 2,
               "45-54": 3,
               "55-64": 4,
               "65 or Over": 5}

inc_mapping = {"Under $25,000": 1,
               "$25,000 - $49,999": 2,
               "$50,000 - $74,999": 3,
               "$75,000 - $99,999": 4,
               "$100,000 - $149,999": 5,
               "$150,000 or Over": 6}

veh_mapping = {"Zero": 0,
               "One": 1,
               "Two": 2,
               "Three or more": 3}

loyalty_mapping = {"Less than a year": 0,
                   "1 - 2 years": 1,
                   "3 - 4 years": 2,
                   "5 - 6 years": 3,
                   "7 - 8 years": 4,
                   "9 - 10 years": 5,
                   "11 - 20 years": 6,
                   "More than 20 years": 7
                   }

freq_mapping = {"Stopped using transit": 0,
                "Less than once a month": 1,
                "1-3 days/month": 2,
                "Once a week": 3,
                "2-3 days/week": 4,
                "4-5 days/week": 5,
                "6-7 days/week": 6}

sat_mapping = {"Very Dissatisfied1": 1,
               "2": 2,
               "3": 3,
               "4": 4,
               "5": 5,
               "6": 6,
               "7": 7,
               "8": 8,
               "9": 9,
               "Very Satisfied10": 10}

sat_txt_mapping = {"Very dissatisfied": 1,
                   "Somewhat dissatisfied": 2,
                   "Neither satisfied nor dissatisfied": 3,
                   "Somewhat satisfied": 4,
                   "Very satisfied": 5}

rec_txt_mapping = {"Very unlikely": 1,
                   "Somewhat unlikely": 2,
                   "Neither likely nor unlikely": 3,
                   "Somewhat likely": 4,
                   "Very likely": 5}

mode_mapping = {"I use multiple modes for my typical transit trip.": "MULTI",
                "CTA Bus": "CTA_BUS",
                "CTA Rail": "CTA_RAIL",
                "Metra": "METRA",
                "Pace": "PACE",
                "ADA Paratransit": "PARA"}

purpose_mapping = {"commuting to/from work": "WORK",
                   "traveling to/from school": "SCHOOL",
                   "business related trips": "BUSINESS",
                   "visiting family/friends": "FAM_FR",
                   "shopping (groceries, supplies)": "SHOP",
                   "medical appointments": "MEDICAL",
                   "personal business": "PERSONAL",
                   "eating/drinking out": "FOOD",
                   "traveling to a place of worship": "RELIGIOUS"}