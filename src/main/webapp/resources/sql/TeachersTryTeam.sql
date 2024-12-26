DECLARE 
    v_category NUMBER := FLOOR(DBMS_RANDOM.VALUE(1,11));
BEGIN
    INSERT INTO POST1 (
        POST_NO,
        POST_TITLE,
        POST_CONTENT,
        VIEW_COUNT,
        LIKE_COUNT,
        CREATE_DATE,
        STATUS,
        IS_PUBLIC,
        IS_NOTICE,
        MEMBER_NO,
        CATEGORY_NO 
    ) VALUES (
        POST_SEQ.NEXTVAL,
        CASE v_category
            WHEN 1 THEN '[맘스뉴스] '
            WHEN 2 THEN '[고민상담] '
            WHEN 3 THEN '[공지사항] '
            WHEN 4 THEN '[초등] '
            WHEN 5 THEN '[중등] '
            WHEN 6 THEN '[고등] '
            WHEN 7 THEN '[고3/N수] '
            WHEN 8 THEN '[지역] '
            WHEN 9 THEN '[학교] '
            WHEN 10 THEN '[자유] '
            ELSE '[기타] '
        END || '게시글 ' || POST_SEQ.CURRVAL || '번입니다',
        '게시글 내용입니다',
        FLOOR(DBMS_RANDOM.VALUE(1,200)),
        FLOOR(DBMS_RANDOM.VALUE(1,200)),
        ADD_MONTHS(TRUNC(SYSDATE), -5) + INTERVAL '10' HOUR * (POST_SEQ.CURRVAL - 1),  -- POST_SEQ.NEXTVAL을 기반으로 날짜 증가
        1,
        1,
        0,
        FLOOR(DBMS_RANDOM.VALUE(1,6)),
        v_category
    );
END;
/




BEGIN
    FOR i IN 1..100 LOOP
        v_category := FLOOR(DBMS_RANDOM.VALUE(1,11));
        INSERT INTO POST1 (
            POST_NO,
            POST_TITLE,
            POST_CONTENT,
            VIEW_COUNT,
            LIKE_COUNT,
            CREATE_DATE,
            STATUS,
            IS_PUBLIC,
            IS_NOTICE,
            MEMBER_NO,
            CATEGORY_NO 
        ) VALUES (
            POST_SEQ.NEXTVAL,
            CASE v_category
                WHEN 1 THEN '[맘스뉴스] '
                WHEN 2 THEN '[고민상담] '
                WHEN 3 THEN '[공지사항] '
                WHEN 4 THEN '[초등] '
                WHEN 5 THEN '[중등] '
                WHEN 6 THEN '[고등] '
                WHEN 7 THEN '[고3/N수] '
                WHEN 8 THEN '[지역] '
                WHEN 9 THEN '[학교] '
                WHEN 10 THEN '[자유] '
                ELSE '[기타] '
            END || '게시글 ' || POST_SEQ.CURRVAL || '번입니다',
            '게시글 내용입니다',
            FLOOR(DBMS_RANDOM.VALUE(1,200)),
            FLOOR(DBMS_RANDOM.VALUE(1,200)),
            ADD_MONTHS(TRUNC(SYSDATE), -5) + INTERVAL '10' HOUR * (POST_SEQ.CURRVAL - 1),  -- POST_SEQ.NEXTVAL을 기반으로 날짜 증가
            1,
            1,
            0,
            FLOOR(DBMS_RANDOM.VALUE(1,6)),
            v_category
        );
    END LOOP;
    COMMIT;
END;