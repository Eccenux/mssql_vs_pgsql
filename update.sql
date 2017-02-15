-- ms/pg int
update alog set deltaT = 0

-- pg text
update alog set url = left(url, 10)

-- ms text
update alog set url = left(cast(url as varchar), 10)