rm(list=ls(all=TRUE))

##########################################################################자신의 PC에서 구글 드라이브가 작동하면 아래 코드로 실습용 엑셀 데이터셋을 호출하면 됩니다

library(googledrive) # 구글 드라이브
library(readxl) # 엑셀 파일 오픈

#두 라이브러리가 설치되어 있지 않으면 아래 코드로 설치하세요
# install.packages("googledrive") #실행시 맨 왼쪽의 # 지우기
# install.packages("readxl") #실행시 맨 왼쪽의 # 지우기

id <- "1dR2EoJoMJVcQjgLATi8GBgllfFf7lBrE" #공유된 엑셀 파일 아이디
k <- tempfile(fileext = ".xlsx"); k

drive_auth(TRUE)
drive_download(as_id(id), k, overwrite = T)
df <- as.data.frame(read_excel(k))

df

#########################################################################
str(df)
