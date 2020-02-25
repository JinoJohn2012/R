#교육용 데이터 불러오기, 모든 객체 삭제
rm(list=ls()) 

#엑셀 파일을 불러오기위한 라이브러리 실행
#만약 라이브러리가 없다면 설치 실행 주석(#) 삭제
#install.packages("readxl") 
library("readxl") 

#방법1
#현재 작업 폴더 확인 후, 교육용 예제 파일(카카오톡으로 받은)을 워킹 디렉토리에 복사 저장
#현재 워킹디렉토리를 확인하기 위해 getwd()을 실행
getwd() 

#file에 파일명을 직접 기록하고 이것을 불러올 예정. 
file <- "V1.data.xlsx" 

#원래는 아래와 같이 full path가 필요하지만 워킹 디렉토리에 데이터를 복사했기 때문에 경로 불필요
#"C:\\Users\\JINOJOHN(M)\\Documents\\V1.R 교육용 Client 샘플데이터.xlsx"
#파일을 복사하기 귀찮다면...

#방법2 - 파일추우즈로 경로를 입력받는 방식 
# file <- file.choose()
# file

#어떤 방법이든 파일명 경로를 받았다면 스크립트의 1행~30행까지 블럭잡고 실행(ctrl + enter)
df<-as.data.frame(read_excel(file)) 
# 괄호안 file이라는 경로에 지정된 파일을 오픈
######################################################################


#2020-02-19(수)
#제3강, 객체와 변수 셋업(교재 3장~5장 요약)

#df의 변수명을 확인하는 방법
colnames(df) #s철자 유의

#변수 레이블
c("id", "매출", "기대수익", "호텔이용", "성별", "연령", "국적", "멤버십 등급", "회원가입일")

#데이터셋 변수 레이블 일괄 적용
colnames(df) <- c("id", "매출", "기대수익", "호텔이용", "성별", "연령", "국적", "멤버십 등급", "회원가입일"); colnames(df)

colnames(df) <- c("id", "sales", "profit", "호텔이용", "성별", "연령", "국적", "멤버십 등급", "회원가입일"); colnames(df)


#개별적으로 적용하기 위해서
colnames(df) <-c("아이디"); colnames(df) #오류

colnames(df) <- c("id", "매출", "기대수익", "호텔이용", "성별", "연령", "국적", "멤버십 등급", "회원가입일"); colnames(df)

#개별적으로 컬럼 이름을 부여하기 위해서 컬럼 이름의 결과가 어떤 구조인지 파악해볼 필요가 있음
#결과를 살펴보면 벡터임 따라서 c()를 통해서 입력 필요
#벡터이기 때문에 []로 위치 지정가능

str(colnames(df))

colnames(df)[8] <- c("class"); colnames(df)

c("id", "sales", "profit", "호텔이용", "성별", "연령", "국적", "멤버십 등급", "회원가입일")

# $방식의 유용성
mean(df$sales)

# []인덱스의 유용성
mean(df[, 1])
mean(df[, 2])
mean(df[, 3])
mean(df[, 6])
mean(df[, 9])

myn<-c(1,2,3,6,9)
myn

for (i in myn){
  r<-mean(df[, i])
  print(r)
}

1:9
# error가 발생하겠지만 일괄 run

for (i in 1:9){
  r<-mean(df[, i])
  print(r)
}

#교재 p.52
apply(df[,c(1,2,3,6,9)], 2, mean)

a <- c(1:6); a
t(a)

b <- matrix(1:6, 3); b
t(b)

df[, 9]
#Year생성하기
df$year <- substr(df[, 9], 1,4)
df$year
#############################################################################
# 핵심 객체 타입 - 6개 유형

#1
#atomic value
i <- 2; i
class(i)

#2
#vector
vt <- c(1,2,3,4,5,6,7,8,9,10); vt
vt <- c(1:10); vt
vt <- c("a", "b", "c"); vt
vt

class(vt)
str(vt)

vt <- paste0("v", 1:10); vt

link <- 1
link<-c(link, link); link

#3
#matrix
mt <- matrix(1:9, 3)
mt
mt[,4] <- c("a", "b", "C") #오류


mt1 <- matrix(1:6, 3, 2); mt1
mt2 <- matrix(1:18, 2, 9); mt2 #mt1의 열의 갯수와 mt2의 행의 갯수가 같아야 계산이 가능

mt1 %*% mt2 #mt1 3행 X mt2 9열 = 27

mt1 <- matrix(1:10, 2, 5); mt1
mt2 <- matrix(1:50, 5, 10); mt2 #2행 10열짜리가 만들어진다

mt1 %*% mt2

#4
#data.frame
df<-as.data.frame(mt)
df[,4] <- c("a", "b", "C")

df[4,] <- c("a", "b", "C", "d")
df
str(df)

#5
#List
l1<-c(1:5); l1
l2<-c(6:10); l2
l3<-c(11:100); l3
l4<-c("a", "b", "c", "d", "e"); l4

lst<-list(l1, l2, l3, l4); lst

str(lst)

lst[[4]][3]

lst<-list(l1, l2, l3, l4, df); lst #ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ


lst<-list(l1, l2, l3); lst

mean(lst) #오류

mean(lst[[1]])
mean(lst[[2]])
mean(lst[[3]])

for (i in 1:3){
  r <- mean(lst[[i]])
  print(r)
}

sapply(lst, mean)
lapply(lst, mean)

txt<-"고객이 머무르고 즐기는 모든 공간에 예술적 품격을 더한 '아트테인먼트'(Art-tainment)를 핵심 가치로 삼고, 사계절 독창적인 경험을 제공한다. 아트워크 3000여 점, 세계적인 수준의 엔터테인먼트, 최신 한류 트렌드 등을 한 자리에서 모두 향유할 수 있는 'K-스타일 데스티네이션'(K-Style Destination)을 구현하며 글로벌 관광산업 미래를 열고 있다.

그 결과, 포브스 트래블 가이드에서의 쾌거 이전에도 국내외 무대에서 두각을 나타내고 있다. 실제 이용객 후기를 기반으로 평가하는 데일리호텔의 '2020 데일리 트루 어워즈'에서 뛰어난 서비스 품질로 '최고의 호텔·리조트' 1위에 올랐다. 씨메르는 문화체육관광부·한국관광공사의 '2019 추천 웰니스 관광지'에 뽑혔다. 원더박스는 세계적인 테마 시설 시상식인 '제26회 TEA 테아 어워즈'(TEA Thea Awards)에서 수상했다.

파라다이스시티 관계자는 '세계적으로 인정받은 차별화한 시설과 콘텐츠를 바탕으로 한국을 대표하는 최고의 휴양지로 더욱더 발돋움하겠다'고 전했다."

txt
class(txt)
str(txt)
txt[1]

lst<-strsplit(txt, "\\. ") #마침표를 기준으로 문자열 분리. //와 \\ 주의
lst
str(lst)
lst[[1]][5]


#6
#Array
ar <- array(1:60, dim=c(3, 4, 5))
ar

ar[, , 3]
ar[, 2, ]
ar[1, , ]
ar[2, 2, 2]

attr(ar, "dim") <- NULL    
ar

str(ar)
class(ar)
mode(ar)

#...
#이외에도 tbl, xts etc
