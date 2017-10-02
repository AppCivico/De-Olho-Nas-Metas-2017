-- Deploy donm:0011-region-variable to pg
-- requires: 0010-subprefecture

BEGIN;

create table variable (
    id integer primary key,
    name text not null
);

insert into variable (id, name) values (19, 'População total'), (27, 'Área total do município em quilômetros quadrados (km²)') ;

alter table region add constraint region_pkey primary key (id) ;

create table region_variable (
    id serial primary key,
    region_id integer not null references region(id),
    variable_id integer not null references variable(id),
    value text not null,
    UNIQUE(region_id, variable_id)
);

COPY region_variable (id, region_id, variable_id, value) FROM stdin;
14	616	19	82452
15	627	19	219870
16	667	19	90138
17	672	19	69260
18	659	19	142863
19	595	19	88883
20	628	19	103502
21	663	19	84637
22	612	19	112741
23	656	19	84831
24	642	19	151905
25	613	19	95616
26	636	19	89722
27	669	19	119830
28	620	19	280082
29	579	19	55104
30	626	19	121051
31	603	19	47542
32	655	19	82382
33	670	19	132979
34	582	19	172062
35	588	19	94098
36	606	19	23851
37	589	19	137833
38	617	19	103713
39	624	19	99498
40	587	19	153049
41	654	19	115154
42	666	19	148298
43	581	19	84499
44	635	19	120582
45	598	19	164784
46	596	19	84077
47	600	19	151715
48	614	19	65278
49	610	19	224475
50	646	19	104295
51	647	19	140845
52	602	19	139315
53	609	19	369498
54	674	19	77324
55	630	19	254354
56	639	19	7982
57	640	19	110610
58	586	19	41984
59	662	19	67709
60	585	19	97637
61	591	19	48590
62	643	19	93163
63	633	19	18538
64	593	19	86981
65	629	19	72110
66	622	19	109379
67	652	19	63710
68	658	19	279279
69	661	19	89465
70	641	19	89331
71	621	19	137529
72	618	19	31302
73	671	19	14952
74	625	19	114037
75	644	19	25460
76	594	19	131620
77	623	19	84484
78	657	19	280372
79	648	19	71813
80	660	19	275196
81	668	19	57771
82	664	19	110885
83	599	19	41353
84	619	19	38288
85	580	19	104921
86	665	19	77280
87	651	19	147127
88	638	19	219083
89	653	19	55795
90	584	19	135827
91	608	19	107795
92	637	19	97626
93	634	19	36158
94	649	19	53868
95	601	19	208054
96	611	19	61912
97	604	19	194784
98	673	19	53624
99	590	19	103100
100	650	19	215417
101	605	19	129759
102	607	19	202118
103	583	19	322255
104	615	19	225810
105	597	19	132479
106	592	19	167744
107	645	19	126973
108	632	19	269670
109	631	19	129588
\.


SELECT pg_catalog.setval('region_variable_id_seq', 109, true);

COMMIT;
