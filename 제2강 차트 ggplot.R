rm(list=ls(all=TRUE))

library(plotly)

# library(RColorBrewer)
# par(mar=c(1,1,1,1))
# display.brewer.all()
# http://colorbrewer2.org/

graphics.off()

#Basic Chart
ggplot(df, aes(x=df[,6], y=df[,2])) + geom_point()

#Basic Chart
ggplot(df, aes(x=df[,6], y=df[,2])) + geom_point() + geom_smooth()

#Save
ggsave("geom_point.png")

#Interactive Chart
ggplotly(Mychart)

#Col
ggplot(df, aes(x=df[,6], y=df[,2])) + geom_point(col="red")


#축, 차트 제목 Label
ggplot(df, aes(x=df[,6], y=df[,2])) + geom_point() +
  xlab("연령") +
  ylab("매출액") +
  ggtitle("연령 매출액 Plot")
  
#Y축
ggplot(df, aes(x=df[,6], y=df[,2])) + geom_point() + 
  scale_y_continuous(labels = function(x) comma(x, 0))

#X축
ggplot(df, aes(x=df[,8], y=df[,2])) + geom_point() + 
  scale_x_discrete(limits=c("레드", "퍼플", "골드"))

ggplot(df, aes(x=df[,6], y=df[,2])) + geom_point() + 
  scale_x_continuous(order(df[,6]))

#X축 라벨 세로
ggplot(df, aes(x=df[,7], y=df[,2])) + geom_point() +
  theme(axis.text.x=element_text(angle=90, hjust=1))

#값LABEL - Tab 생성 후 구현
tab <- df %>% group_by(df[,8]) %>% 
  summarise(mean(매출)) %>% as.data.frame()

#Tab 요약결과 이용
ggplot(tab, aes(x=tab[,1], y=tab[,2])) + geom_col() +
  geom_text(position = position_stack(vjust=.5),
            aes(label = comma(as.numeric(..y..),0)), 
            col="white",
            size=3)

#Fill 변수
ggplot(df, aes(x=df[,4], y=df[,3], fill=df[,4])) + geom_col()

#Fill 변수
ggplot(df, aes(x=df[,4], y=df[,3], fill=df[,5])) + geom_col(position="fill")



#파이차트
ggplot(df, aes(x="", y=df[,4], fill=df[,4]))+
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0)

# geom_bar() #바차트
# geom_line() #라인차트
# geom_smooth() # 추세선
# coord_flip() # 가로세로축 바꾸기
# theme(legend.position="none") # 범례지우기
# scale_color_brewer(palette = "OrRd") # 색상
# scale_y_continuous(breaks = fivenum(df[,2]), #y축 구간 변경
#                    labels = c(1,2,3,4,5)) #변경 구간 레이블
# guides(fill=guide_legend(reverse = T)) + #범례
# facet_wrap(~df[,7]) # 다중 차트 # 물결표시 주의

