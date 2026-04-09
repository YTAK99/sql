/*
USED_GOODS_BOARD와 USED_GOODS_REPLY 테이블에서 2022년 10월에 작성된 게시글 제목, 게시글 ID, 댓글 ID, 댓글 작성자 ID, 댓글 내용, 댓글 작성일을 조회하는 SQL문을 작성해주세요. 
결과는 댓글 작성일을 기준으로 오름차순 정렬해주시고, 댓글 작성일이 같다면 게시글 제목을 기준으로 오름차순 정렬해주세요.
*/


SELECT TITLE, b.BOARD_ID, REPLY_ID, r.WRITER_ID, r.CONTENTS, TO_CHAR(r.CREATED_DATE, 'YYYY-MM-DD')
FROM USED_GOODS_BOARD b, USED_GOODS_REPLY r
where b.BOARD_ID = r.BOARD_ID
    and to_char(b.created_date, 'YYYY-MM') = '2022-10'
order by 6, 1
