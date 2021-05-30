class AddIntDictConfigrations < ActiveRecord::Migration[5.2]
  def up
    say_with_time("Adding configuration for dict_int") do
      execute <<~'SQL'.squish
        CREATE TEXT SEARCH CONFIGURATION public.cv_en ( COPY = pg_catalog.english );
        CREATE TEXT SEARCH DICTIONARY cv_en_intdict ( TEMPLATE = intdict_template );
        ALTER TEXT SEARCH DICTIONARY cv_en_intdict (MAXLEN = 12, ABSVAL=true);
        ALTER TEXT SEARCH CONFIGURATION cv_en
          ALTER MAPPING FOR int, uint WITH cv_en_intdict;

        CREATE TEXT SEARCH CONFIGURATION public.cv_it ( COPY = pg_catalog.italian );
        CREATE TEXT SEARCH DICTIONARY cv_it_intdict ( TEMPLATE = intdict_template );
        ALTER TEXT SEARCH DICTIONARY cv_it_intdict (MAXLEN = 12, ABSVAL=true);
        ALTER TEXT SEARCH CONFIGURATION cv_it
          ALTER MAPPING FOR int, uint WITH cv_it_intdict;
      SQL
    end
  end

  def down
    say_with_time("Restoring configuration for dict_int") do
      execute <<~'SQL'.squish
        DROP TEXT SEARCH CONFIGURATION public.cv_en;
        DROP TEXT SEARCH CONFIGURATION public.cv_it;
        DROP TEXT SEARCH DICTIONARY cv_en_intdict;
        DROP TEXT SEARCH DICTIONARY cv_it_intdict;
      SQL
    end
  end
end
