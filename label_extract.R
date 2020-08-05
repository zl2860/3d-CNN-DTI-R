library(tidyverse)
# read data
abcd_ksad = read.table('./label/abcd_ksad01.txt', header = T) %>% 
  .[-1,] %>%
  select(src_subject_id, ksads_14_853_p) %>%
  mutate(src_subject_id = str_remove(src_subject_id, "_"))

# gather all the subject IDs:
subjects = list.files('C:/Users/zongchao liu/PycharmProjects/3d-CNN-DTI/data/img')
subjects = str_remove(subjects, "sub-")
out = abcd_ksad %>%
  filter(src_subject_id %in% subjects) %>%
  distinct(src_subject_id, .keep_all = TRUE) %>%
  rename("id" = "src_subject_id" ,
         "label" = "ksads_14_853_p") %>%
  filter(id != "NDARINVH3MZK10Z")

write.csv(out, file = './label.csv')
