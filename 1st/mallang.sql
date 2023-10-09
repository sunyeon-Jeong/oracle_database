-- 1. hr(humanResource) 계정생성
create user humanResource identified by oracle
default tablespace users quota unlimited on users;

-- 2. hr계정 -> connect, resource 접근권환부여
grant connect, resource to humanresource;
--------------------------------------------------------------------------------
-- 테이블스페이스 확인
select * from dba_tablespaces;

-- 테이블스페이스 정보 열람
--     보기 > dba
--     저장영역 > 테이블스페이스