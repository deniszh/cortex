CREATE KEYSPACE IF NOT EXISTS cortex_test
		 WITH replication = {
			 'class' : 'SimpleStrategy',
			 'replication_factor' : 1
};
