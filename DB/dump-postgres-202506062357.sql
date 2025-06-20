PGDMP  "    9                }            postgres    17.4    17.4 M    u           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            v           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            w           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            x           1262    5    postgres    DATABASE     j   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE postgres;
                     postgres    false            y           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                        postgres    false    3704                        2615    16533    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     postgres    false            z           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                        postgres    false    5            �            1259    16591 	   companies    TABLE     �   CREATE TABLE public.companies (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    address text,
    contact_phone character varying(20),
    contact_email character varying(50)
);
    DROP TABLE public.companies;
       public         heap r       postgres    false    5            �            1259    16590    companies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.companies_id_seq;
       public               postgres    false    226    5            {           0    0    companies_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;
          public               postgres    false    225            �            1259    16579 	   employees    TABLE     _  CREATE TABLE public.employees (
    id integer NOT NULL,
    "position" character varying(50) NOT NULL,
    faculty_id integer,
    lastname character varying(30) NOT NULL,
    name character varying(30) NOT NULL,
    fathername character varying(30),
    date_of_birth date,
    email character varying(50),
    phone_number character varying(15)
);
    DROP TABLE public.employees;
       public         heap r       postgres    false    5            �            1259    16578    employees_id_seq    SEQUENCE     �   CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.employees_id_seq;
       public               postgres    false    224    5            |           0    0    employees_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;
          public               postgres    false    223            �            1259    16535 	   faculties    TABLE     f   CREATE TABLE public.faculties (
    id integer NOT NULL,
    title character varying(100) NOT NULL
);
    DROP TABLE public.faculties;
       public         heap r       postgres    false    5            �            1259    16534    faculties_id_seq    SEQUENCE     �   CREATE SEQUENCE public.faculties_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.faculties_id_seq;
       public               postgres    false    5    218            }           0    0    faculties_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.faculties_id_seq OWNED BY public.faculties.id;
          public               postgres    false    217            �            1259    16555    groups    TABLE     	  CREATE TABLE public.groups (
    group_number character varying(15) NOT NULL,
    program_code character varying(10) NOT NULL,
    course_number smallint NOT NULL,
    CONSTRAINT groups_course_number_check CHECK (((course_number >= 1) AND (course_number <= 6)))
);
    DROP TABLE public.groups;
       public         heap r       postgres    false    5            �            1259    16602    practice_places    TABLE       CREATE TABLE public.practice_places (
    id integer NOT NULL,
    type character varying(20) NOT NULL,
    faculty_id integer,
    company_id integer,
    CONSTRAINT chk_place_type CHECK (((((type)::text = 'faculty'::text) AND (faculty_id IS NOT NULL) AND (company_id IS NULL)) OR (((type)::text = 'company'::text) AND (company_id IS NOT NULL) AND (faculty_id IS NULL)))),
    CONSTRAINT practice_places_type_check CHECK (((type)::text = ANY ((ARRAY['faculty'::character varying, 'company'::character varying])::text[])))
);
 #   DROP TABLE public.practice_places;
       public         heap r       postgres    false    5            �            1259    16601    practice_places_id_seq    SEQUENCE     �   CREATE SEQUENCE public.practice_places_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.practice_places_id_seq;
       public               postgres    false    228    5            ~           0    0    practice_places_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.practice_places_id_seq OWNED BY public.practice_places.id;
          public               postgres    false    227            �            1259    16621    practice_timetable    TABLE     �  CREATE TABLE public.practice_timetable (
    id integer NOT NULL,
    program_code character varying(10) NOT NULL,
    course_number smallint NOT NULL,
    practice_kind character varying(20) NOT NULL,
    practice_type character varying(200) NOT NULL,
    director_id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    place_faculty_id integer,
    CONSTRAINT practice_timetable_course_number_check CHECK (((course_number >= 1) AND (course_number <= 6))),
    CONSTRAINT practice_timetable_practice_kind_check CHECK (((practice_kind)::text = ANY ((ARRAY['Учебная'::character varying, 'Производственная'::character varying, 'Преддипломная'::character varying])::text[])))
);
 &   DROP TABLE public.practice_timetable;
       public         heap r       postgres    false    5            �            1259    16620    practice_timetable_id_seq    SEQUENCE     �   CREATE SEQUENCE public.practice_timetable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.practice_timetable_id_seq;
       public               postgres    false    230    5                       0    0    practice_timetable_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.practice_timetable_id_seq OWNED BY public.practice_timetable.id;
          public               postgres    false    229            �            1259    16543    programs    TABLE     ~  CREATE TABLE public.programs (
    code character varying(10) NOT NULL,
    title character varying(50) NOT NULL,
    degree character varying(15),
    form character varying(15),
    faculty_id integer NOT NULL,
    CONSTRAINT programs_degree_check CHECK (((degree)::text = ANY ((ARRAY['Бакалавриат'::character varying, 'Магистратура'::character varying, 'Специалитет'::character varying])::text[]))),
    CONSTRAINT programs_form_check CHECK (((form)::text = ANY ((ARRAY['Очная'::character varying, 'Очно-заочная'::character varying, 'Заочная'::character varying])::text[])))
);
    DROP TABLE public.programs;
       public         heap r       postgres    false    5            �            1259    16645    student_practice_assignments    TABLE     �   CREATE TABLE public.student_practice_assignments (
    id integer NOT NULL,
    student_id integer NOT NULL,
    practice_id integer NOT NULL,
    practice_place_id integer NOT NULL
);
 0   DROP TABLE public.student_practice_assignments;
       public         heap r       postgres    false    5            �            1259    16644 #   student_practice_assignments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_practice_assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.student_practice_assignments_id_seq;
       public               postgres    false    5    232            �           0    0 #   student_practice_assignments_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.student_practice_assignments_id_seq OWNED BY public.student_practice_assignments.id;
          public               postgres    false    231            �            1259    16567    students    TABLE     H  CREATE TABLE public.students (
    id integer NOT NULL,
    lastname character varying(30) NOT NULL,
    name character varying(30) NOT NULL,
    fathername character varying(30),
    group_number character varying(15) NOT NULL,
    date_of_birth date,
    email character varying(50),
    phone_number character varying(15)
);
    DROP TABLE public.students;
       public         heap r       postgres    false    5            �            1259    16566    students_id_seq    SEQUENCE     �   CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.students_id_seq;
       public               postgres    false    5    222            �           0    0    students_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;
          public               postgres    false    221            �           2604    16594    companies id    DEFAULT     l   ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);
 ;   ALTER TABLE public.companies ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    225    226            �           2604    16582    employees id    DEFAULT     l   ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);
 ;   ALTER TABLE public.employees ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    224    223    224            �           2604    16538    faculties id    DEFAULT     l   ALTER TABLE ONLY public.faculties ALTER COLUMN id SET DEFAULT nextval('public.faculties_id_seq'::regclass);
 ;   ALTER TABLE public.faculties ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            �           2604    16605    practice_places id    DEFAULT     x   ALTER TABLE ONLY public.practice_places ALTER COLUMN id SET DEFAULT nextval('public.practice_places_id_seq'::regclass);
 A   ALTER TABLE public.practice_places ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    227    228    228            �           2604    16624    practice_timetable id    DEFAULT     ~   ALTER TABLE ONLY public.practice_timetable ALTER COLUMN id SET DEFAULT nextval('public.practice_timetable_id_seq'::regclass);
 D   ALTER TABLE public.practice_timetable ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    230    229    230            �           2604    16648    student_practice_assignments id    DEFAULT     �   ALTER TABLE ONLY public.student_practice_assignments ALTER COLUMN id SET DEFAULT nextval('public.student_practice_assignments_id_seq'::regclass);
 N   ALTER TABLE public.student_practice_assignments ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    231    232    232            �           2604    16570    students id    DEFAULT     j   ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);
 :   ALTER TABLE public.students ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221    222            l          0    16591 	   companies 
   TABLE DATA           T   COPY public.companies (id, name, address, contact_phone, contact_email) FROM stdin;
    public               postgres    false    226   �g       j          0    16579 	   employees 
   TABLE DATA              COPY public.employees (id, "position", faculty_id, lastname, name, fathername, date_of_birth, email, phone_number) FROM stdin;
    public               postgres    false    224   Sh       d          0    16535 	   faculties 
   TABLE DATA           .   COPY public.faculties (id, title) FROM stdin;
    public               postgres    false    218   �i       f          0    16555    groups 
   TABLE DATA           K   COPY public.groups (group_number, program_code, course_number) FROM stdin;
    public               postgres    false    220   �j       n          0    16602    practice_places 
   TABLE DATA           K   COPY public.practice_places (id, type, faculty_id, company_id) FROM stdin;
    public               postgres    false    228   �j       p          0    16621    practice_timetable 
   TABLE DATA           �   COPY public.practice_timetable (id, program_code, course_number, practice_kind, practice_type, director_id, start_date, end_date, place_faculty_id) FROM stdin;
    public               postgres    false    230   k       e          0    16543    programs 
   TABLE DATA           I   COPY public.programs (code, title, degree, form, faculty_id) FROM stdin;
    public               postgres    false    219   ]l       r          0    16645    student_practice_assignments 
   TABLE DATA           f   COPY public.student_practice_assignments (id, student_id, practice_id, practice_place_id) FROM stdin;
    public               postgres    false    232   [m       h          0    16567    students 
   TABLE DATA           t   COPY public.students (id, lastname, name, fathername, group_number, date_of_birth, email, phone_number) FROM stdin;
    public               postgres    false    222   �m       �           0    0    companies_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.companies_id_seq', 2, true);
          public               postgres    false    225            �           0    0    employees_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.employees_id_seq', 4, true);
          public               postgres    false    223            �           0    0    faculties_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.faculties_id_seq', 4, true);
          public               postgres    false    217            �           0    0    practice_places_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.practice_places_id_seq', 10, true);
          public               postgres    false    227            �           0    0    practice_timetable_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.practice_timetable_id_seq', 12, true);
          public               postgres    false    229            �           0    0 #   student_practice_assignments_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.student_practice_assignments_id_seq', 4, true);
          public               postgres    false    231            �           0    0    students_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.students_id_seq', 4, true);
          public               postgres    false    221            �           2606    16600    companies companies_name_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_name_key UNIQUE (name);
 F   ALTER TABLE ONLY public.companies DROP CONSTRAINT companies_name_key;
       public                 postgres    false    226            �           2606    16598    companies companies_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.companies DROP CONSTRAINT companies_pkey;
       public                 postgres    false    226            �           2606    16584    employees employees_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public                 postgres    false    224            �           2606    16540    faculties faculties_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.faculties
    ADD CONSTRAINT faculties_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.faculties DROP CONSTRAINT faculties_pkey;
       public                 postgres    false    218            �           2606    16670    faculties faculties_title_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.faculties
    ADD CONSTRAINT faculties_title_key UNIQUE (title);
 G   ALTER TABLE ONLY public.faculties DROP CONSTRAINT faculties_title_key;
       public                 postgres    false    218            �           2606    16560    groups groups_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (group_number);
 <   ALTER TABLE ONLY public.groups DROP CONSTRAINT groups_pkey;
       public                 postgres    false    220            �           2606    16609 $   practice_places practice_places_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.practice_places
    ADD CONSTRAINT practice_places_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.practice_places DROP CONSTRAINT practice_places_pkey;
       public                 postgres    false    228            �           2606    16628 *   practice_timetable practice_timetable_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.practice_timetable
    ADD CONSTRAINT practice_timetable_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.practice_timetable DROP CONSTRAINT practice_timetable_pkey;
       public                 postgres    false    230            �           2606    16549    programs programs_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.programs
    ADD CONSTRAINT programs_pkey PRIMARY KEY (code);
 @   ALTER TABLE ONLY public.programs DROP CONSTRAINT programs_pkey;
       public                 postgres    false    219            �           2606    16650 >   student_practice_assignments student_practice_assignments_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.student_practice_assignments
    ADD CONSTRAINT student_practice_assignments_pkey PRIMARY KEY (id);
 h   ALTER TABLE ONLY public.student_practice_assignments DROP CONSTRAINT student_practice_assignments_pkey;
       public                 postgres    false    232            �           2606    16652 T   student_practice_assignments student_practice_assignments_student_id_practice_id_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.student_practice_assignments
    ADD CONSTRAINT student_practice_assignments_student_id_practice_id_key UNIQUE (student_id, practice_id);
 ~   ALTER TABLE ONLY public.student_practice_assignments DROP CONSTRAINT student_practice_assignments_student_id_practice_id_key;
       public                 postgres    false    232    232            �           2606    16572    students students_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.students DROP CONSTRAINT students_pkey;
       public                 postgres    false    222            �           2606    16585 #   employees employees_faculty_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculties(id);
 M   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_faculty_id_fkey;
       public               postgres    false    3503    218    224            �           2606    16561    groups groups_program_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_program_code_fkey FOREIGN KEY (program_code) REFERENCES public.programs(code);
 I   ALTER TABLE ONLY public.groups DROP CONSTRAINT groups_program_code_fkey;
       public               postgres    false    3507    219    220            �           2606    16615 /   practice_places practice_places_company_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.practice_places
    ADD CONSTRAINT practice_places_company_id_fkey FOREIGN KEY (company_id) REFERENCES public.companies(id);
 Y   ALTER TABLE ONLY public.practice_places DROP CONSTRAINT practice_places_company_id_fkey;
       public               postgres    false    228    3517    226            �           2606    16610 /   practice_places practice_places_faculty_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.practice_places
    ADD CONSTRAINT practice_places_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculties(id);
 Y   ALTER TABLE ONLY public.practice_places DROP CONSTRAINT practice_places_faculty_id_fkey;
       public               postgres    false    228    3503    218            �           2606    16634 6   practice_timetable practice_timetable_director_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.practice_timetable
    ADD CONSTRAINT practice_timetable_director_id_fkey FOREIGN KEY (director_id) REFERENCES public.employees(id);
 `   ALTER TABLE ONLY public.practice_timetable DROP CONSTRAINT practice_timetable_director_id_fkey;
       public               postgres    false    230    3513    224            �           2606    16639 ;   practice_timetable practice_timetable_place_faculty_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.practice_timetable
    ADD CONSTRAINT practice_timetable_place_faculty_id_fkey FOREIGN KEY (place_faculty_id) REFERENCES public.faculties(id);
 e   ALTER TABLE ONLY public.practice_timetable DROP CONSTRAINT practice_timetable_place_faculty_id_fkey;
       public               postgres    false    230    3503    218            �           2606    16629 7   practice_timetable practice_timetable_program_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.practice_timetable
    ADD CONSTRAINT practice_timetable_program_code_fkey FOREIGN KEY (program_code) REFERENCES public.programs(code);
 a   ALTER TABLE ONLY public.practice_timetable DROP CONSTRAINT practice_timetable_program_code_fkey;
       public               postgres    false    230    3507    219            �           2606    16550 !   programs programs_faculty_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.programs
    ADD CONSTRAINT programs_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculties(id);
 K   ALTER TABLE ONLY public.programs DROP CONSTRAINT programs_faculty_id_fkey;
       public               postgres    false    219    3503    218            �           2606    16658 J   student_practice_assignments student_practice_assignments_practice_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_practice_assignments
    ADD CONSTRAINT student_practice_assignments_practice_id_fkey FOREIGN KEY (practice_id) REFERENCES public.practice_timetable(id);
 t   ALTER TABLE ONLY public.student_practice_assignments DROP CONSTRAINT student_practice_assignments_practice_id_fkey;
       public               postgres    false    3521    232    230            �           2606    16663 P   student_practice_assignments student_practice_assignments_practice_place_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_practice_assignments
    ADD CONSTRAINT student_practice_assignments_practice_place_id_fkey FOREIGN KEY (practice_place_id) REFERENCES public.practice_places(id);
 z   ALTER TABLE ONLY public.student_practice_assignments DROP CONSTRAINT student_practice_assignments_practice_place_id_fkey;
       public               postgres    false    232    228    3519            �           2606    16653 I   student_practice_assignments student_practice_assignments_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_practice_assignments
    ADD CONSTRAINT student_practice_assignments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id);
 s   ALTER TABLE ONLY public.student_practice_assignments DROP CONSTRAINT student_practice_assignments_student_id_fkey;
       public               postgres    false    3511    222    232            �           2606    16573 #   students students_group_number_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_group_number_fkey FOREIGN KEY (group_number) REFERENCES public.groups(group_number);
 M   ALTER TABLE ONLY public.students DROP CONSTRAINT students_group_number_fkey;
       public               postgres    false    222    220    3509            l   �   x�}�;
�PE�U<���cb�Bl���`
+5�.@���CԘ��ΎB+���̹�#pD�;m���mx���:�x�Dʛ�RS�ŴBICR��oJh�W�*C:�hy�c[n��{m��Q��A���f	\}�A;d�����r*������Hc{�0�Ӥ���͐���eٶ��8���x>�v���} �ꌱ      j   W  x�e�KJA��էp/=�cz;O�	��8�`��$0�<D]�Q�F�!11��oduT�ꦪ����X�K\�|��l��x�#\ڞ���9��q�_8���z2>W
N�v�u��p�h��$o��S//`;�e �TJk�H��3�m��v�\P�|�.�HYQ�������8�����#�Eȥ����Lڭ�S����T���}c�v��$"��v�w��2���QP���oX�qj�RG��������H�^~���a�|�W�^�sWĬpE�1�(1����fݻPk��O�C�QBm��#.Wgy�u��M{`�(�c!X�c�}�=�#      d   �   x�mO9�0��W�(�sxLp4 ����EV��I����1���ly�;;Ǵ�IV��I-�J��T�h�# qp�X٣��߈�u�<�f��%'����E�l�$O��/Ŕ�>'��u�o�n�D<~�����c/;�qf�'���ɥ��:������Mh��`�����F�̲4Ƽ_��0      f   @   x�=��	 1���.	v�����+��zH�����AY��Ki�8��Kˊ�)��ӯ�U; |8�l      n   5   x�3�L��-H̫���4�@�qYr�%&��Tr��|C?F��� q��      p   6  x��QKN�0]�O��h���ޅôi��"�GB,� D�4I�0�ώ�V�HY83�yo�0y.�*ِ'y;��]Fy��
9�$ǰI�Q��K]XI����a�PBa
[4�a-=8� �!�F�Y@>o
i�P3P�A8J���5���H�M���M�M�F�tԙ���]�j�aՈ�B�	�s9�@��'G����h��J��vANC���2�H�	7П�M�&9<��h��3Ș[6��<O�`��Xr�|�����g���Ҏɨ%��I���'��������h�� �nE��������ȫ�R)�T�a�      e   �   x�}PMj1^'��8�u�Yz��,*��KA�Bj�c���{O���B�^����.+���	�H�:����Le��:��a#��hݝ��=sK�ٶ���/$$t��Ɉ��8��'��N�7���,k_We56K�8P�`�,o�2Å�A�J�\���,K��Q(�!2�,6��aE\�Xշ!��<H��i�G�>��&S}����t���M��X�cb���C�Pz�F"%      r   -   x���  ��^1����C�9�����(�㟡�$=n9      h   .  x�M�MJA���W����w7'��4:��	2DWj7.��p#���`̘���F�N����x�{��z�hK;�^i�m���@o�Gk���i�B��3`�ԩ���*�A��f��.���Vup3��$��	�8h�.Ñ���1xc��Jd���D�(m]-s���m.��	��(4U&��6�s|������V��u��J�� fY&y6
��zRۢ��m������7R��'i���:��f��-臩�{�"��ٝlP�� �6(���aj����쮨�(N�:��(B�r᭢     