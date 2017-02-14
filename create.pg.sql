DROP TABLE IF EXISTS alog;

CREATE TABLE alog
(
	id BIGSERIAL PRIMARY KEY,
	
	ip varchar(40),
	deltaT int,
	method varchar(20),
	url text
);

CREATE INDEX ip_idx ON alog (ip);
