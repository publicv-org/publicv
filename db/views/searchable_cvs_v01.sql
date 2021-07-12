SELECT
 cvs.id as cv_id,
 users.id as user_id,
 users.subdomain as subdomain,
 users.first_name as first_name,
 users.last_name as last_name,
 MIN(locations.latitude) as latitude,
 MIN(locations.longitude) as longitude,
 MIN(locations.original_address) as original_address,

 (
    setweight(to_tsvector('cv_en', coalesce(cvs.about , '')), 'B') ||
    setweight(to_tsvector('cv_en', coalesce(cvs.skills , '')), 'B') ||
    setweight(to_tsvector('cv_en', coalesce(cvs.working_skills , '')), 'A') ||
    setweight(to_tsvector('cv_en', coalesce(users.first_name , '')), 'A') ||
    setweight(to_tsvector('cv_en', coalesce(users.last_name , '')), 'A') ||
    setweight(to_tsvector('cv_en', coalesce(STRING_AGG(locations.city || locations.country, ' '), '')), 'B') ||
    setweight(to_tsvector('cv_en', coalesce(STRING_AGG(locations.geocoded_address || locations.original_address, ' '), '')), 'D') ||
    setweight(to_tsvector('cv_en', coalesce(STRING_AGG(educations.degree || educations.description || educations.school, ' '), '')), 'D') ||
    setweight(to_tsvector('cv_en', coalesce(STRING_AGG(languages.language || languages.level, ' '), '')), 'C') ||
    setweight(to_tsvector('cv_en', coalesce(STRING_AGG(experiences.company || experiences.description || experiences.title, ' '), '')), 'C')
 ) as search_en_content_tsvector,

 (
    setweight(to_tsvector('cv_it', coalesce(cvs.about , '')), 'B') ||
    setweight(to_tsvector('cv_it', coalesce(cvs.skills , '')), 'B') ||
    setweight(to_tsvector('cv_it', coalesce(cvs.working_skills , '')), 'A') ||
    setweight(to_tsvector('cv_it', coalesce(users.first_name , '')), 'A') ||
    setweight(to_tsvector('cv_it', coalesce(users.last_name , '')), 'A') ||
    setweight(to_tsvector('cv_it', coalesce(STRING_AGG(locations.city || locations.country, ' '), '')), 'B') ||
    setweight(to_tsvector('cv_it', coalesce(STRING_AGG(locations.geocoded_address || locations.original_address, ' '), '')), 'D') ||
    setweight(to_tsvector('cv_it', coalesce(STRING_AGG(educations.degree || educations.description || educations.school, ' '), '')), 'D') ||
    setweight(to_tsvector('cv_it', coalesce(STRING_AGG(languages.language || languages.level, ' '), '')), 'C') ||
    setweight(to_tsvector('cv_it', coalesce(STRING_AGG(experiences.company || experiences.description || experiences.title, ' '), '')), 'C')
 ) as search_it_content_tsvector

FROM cvs

INNER JOIN users ON users.id = cvs.user_id
LEFT JOIN locations ON locations.user_id = users.id
LEFT JOIN educations ON educations.cv_id = cvs.id
LEFT JOIN languages ON languages.cv_id = cvs.id
LEFT JOIN experiences ON experiences.cv_id = cvs.id

WHERE 
  cvs.published = true

GROUP BY 
  cvs.id, users.id

