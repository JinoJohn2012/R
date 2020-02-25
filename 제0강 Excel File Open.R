# 경로명을 만드는 방법
a <- "C:\\Users\\JINOJOHN(M)\\OneDrive - 고려대학교\\0000.ACE LECTURE\\2020.파라다이스.R교육\\R Data Example"; a

b <- "V1.R 교육용 Client 샘플데이터.xlsx"; b

path<-paste0(a,"\\",b) #괄호뒤에 있는 문자열들을 모두 합치기
path

path<-file.choose() # 이런 과정이 불편하기 때문에 파일 선택을 통해 엑셀 파일의 위치 정보 문자열을 선택해서 저장

######################################################################

# 강의 자료 구글 드라이브에서 받아 오기(매 강의 마다 드라이브에서 받아올 예정으로, 실행이 안되는 분들은 개별적으로 문의해서 모두 작동되어야 합니다)

id <- "1dR2EoJoMJVcQjgLATi8GBgllfFf7lBrE" #공유된 엑셀 파일 아이디
k <- tempfile(fileext = ".xlsx"); k
drive_download(as_id(id), k, overwrite = T)
1 
df <- read_excel(k)
df <- as.data.frame(df) # 왜 객체를 변환하는지 이해하는 것이 제2강 핵심 목적

# 이 작업이 안되는 경우, path<-file.choose 로 하드 드라이브 파일 오픈
