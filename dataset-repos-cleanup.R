# Preps the list of schema.org-compliant datasets for creating a web form

library(googlesheets)
library(tidyverse)
library(jsonlite)

url = "https://docs.google.com/spreadsheets/d/1K1Jqy3CeCtRYtgC3RiC1FICqQFA8sCy2h5UafiAFk-U/edit"

gs = googlesheets::gs_url(url)
df = gs_read_csv(gs)

# split categories, recommender
df = df %>% 
  mutate(category = str_split(category, ", "),
         recommender = str_split(recommender, ", "),
         schemaorgCompliant = as.logical(schemaorgCompliant))

df_json = df %>% jsonlite::toJSON()
write(df_json, "GitHub/dataset-repository-selector/dataset_repositories.json")
