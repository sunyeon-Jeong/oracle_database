-- 1. hr(humanResource) 계정생성
create user humanResource identified by oracle
default tablespace users quota unlimited on users;

-- 2. hr계정 -> connect, resource 접근권환부여
grant connect, resource to humanresource;