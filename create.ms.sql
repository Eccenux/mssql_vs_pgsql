DROP TABLE IF EXISTS alog;

CREATE TABLE alog
(
	id [bigint] IDENTITY(1,1) NOT NULL,
	
	ip varchar(40),
	deltaT int,
	method varchar(20),
	url text,
	
	PRIMARY KEY (id)
);

CREATE INDEX ip_idx ON alog (ip);
