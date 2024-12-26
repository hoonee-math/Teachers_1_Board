DROP TABLE "COMMENT1";

CREATE TABLE "COMMENT1" (
	"COMMENT_NO"	NUMBER		NOT NULL,
	"PARENT_NO"	NUMBER		 NULL,
	"COMMENT_CONTENT"	VARCHAR2(200)		NULL,
	"CREATE_DATE"	DATE		NULL,
	"UPDATE_DATE"	DATE		NULL,
	"COMMENT_LEVEL"	NUMBER		NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"POST_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "COMMENT1"."COMMENT_NO" IS '자동부여';

COMMENT ON COLUMN "COMMENT1"."CREATE_DATE" IS '자동부여';

COMMENT ON COLUMN "COMMENT1"."UPDATE_DATE" IS '자동부여';

COMMENT ON COLUMN "COMMENT1"."COMMENT_LEVEL" IS 'check/1,2';

COMMENT ON COLUMN "COMMENT1"."MEMBER_NO" IS '자동부여';


select * from comment1;










CREATE SEQUENCE SEQ_COMMENT_NO
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

DROP table comment;
    
DECLARE
    v_member_no NUMBER;
    v_post_no NUMBER;
    v_comment_content VARCHAR2(100);
BEGIN
    FOR i IN 1..200 LOOP
        -- 랜덤 값 생성
        v_member_no := FLOOR(DBMS_RANDOM.VALUE(1, 14)); -- 1~13
        v_post_no := FLOOR(DBMS_RANDOM.VALUE(300, 358)); -- 300~397
        v_comment_content := v_member_no || 'Write Comment'  ;

        -- 데이터 삽입
        INSERT INTO COMMENT1 (
            COMMENT_NO,
            PARENT_NO,
            COMMENT_CONTENT,
            CREATE_DATE,
            UPDATE_DATE,
            COMMENT_LEVEL,
            MEMBER_NO,
            POST_NO
        ) VALUES (
            SEQ_COMMENT_NO.NEXTVAL,
            1, -- PARENT_NO는 null 가능
            v_comment_content,
            SYSDATE, -- CREATE_DATE
            SYSDATE, -- UPDATE_DATE
            2, -- COMMENT_LEVEL 기본값 1
            v_member_no, -- MEMBER_NO
            v_post_no -- POST_NO
        );
    END LOOP;
    COMMIT;
END;
/

select * from comment1;

ALTER TABLE COMMENT1 MODIFY PARENT_NO NULL;

commit;