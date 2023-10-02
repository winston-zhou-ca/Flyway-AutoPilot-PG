-- Script generated by Redgate Compare v1.15.2.10618
SET check_function_bodies = false;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.account_roles...';END$$;
CREATE TABLE public.account_roles (
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    grant_date timestamp without time zone
);
ALTER TABLE public.account_roles ADD CONSTRAINT account_roles_pkey PRIMARY KEY (user_id, role_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.autopilot...';END$$;
CREATE TABLE public.autopilot (
    postgres character varying,
    auto character varying,
    pilot character varying
);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.insert_data(integer, integer)...';END$$;
CREATE PROCEDURE public.insert_data(IN a integer, IN b integer)
LANGUAGE sql
AS $_$
INSERT INTO accounts VALUES (a);
INSERT INTO account_roles VALUES (b);
$_$;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.roles_role_id_seq...';END$$;
CREATE SEQUENCE public.roles_role_id_seq
AS integer
INCREMENT BY 1
MINVALUE 1
MAXVALUE 2147483647
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.roles...';END$$;
CREATE TABLE public.roles (
    role_id integer NOT NULL DEFAULT nextval('public.roles_role_id_seq'::regclass),
    role_name character varying(255) NOT NULL
);
ALTER TABLE public.roles ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.roles_role_id_seq...';END$$;
ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.account_roles.account_roles_role_id_fkey...';END$$;
ALTER TABLE public.account_roles ADD CONSTRAINT account_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles (role_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.accounts_user_id_seq...';END$$;
CREATE SEQUENCE public.accounts_user_id_seq
AS integer
INCREMENT BY 1
MINVALUE 1
MAXVALUE 2147483647
START 1
CACHE 1
NO CYCLE;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.accounts...';END$$;
CREATE TABLE public.accounts (
    user_id integer NOT NULL DEFAULT nextval('public.accounts_user_id_seq'::regclass),
    username character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    last_login timestamp without time zone
);
ALTER TABLE public.accounts ADD CONSTRAINT accounts_pkey PRIMARY KEY (user_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Altering public.accounts_user_id_seq...';END$$;
ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts.user_id;


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.account_roles.account_roles_user_id_fkey...';END$$;
ALTER TABLE public.account_roles ADD CONSTRAINT account_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.accounts (user_id);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.roles_role_name_key...';END$$;
CREATE UNIQUE INDEX roles_role_name_key ON public.roles USING btree (role_name);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.accounts_username_key...';END$$;
CREATE UNIQUE INDEX accounts_username_key ON public.accounts USING btree (username);


DO language plpgsql $$BEGIN RAISE NOTICE 'Creating public.accounts_email_key...';END$$;
CREATE UNIQUE INDEX accounts_email_key ON public.accounts USING btree (email);

SET check_function_bodies = true;
