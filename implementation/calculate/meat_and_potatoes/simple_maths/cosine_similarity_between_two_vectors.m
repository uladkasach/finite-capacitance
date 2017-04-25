function cosine_similarity = cosine_similarity_between_two_vectors(vector_a, vector_b)
    %% cos(theta) = A dot B / (|A||B|)
    %dot(vector_a, vector_b)
    %magnitude_of_vector(vector_a)
    %magnitude_of_vector(vector_b)
    cosine_similarity = dot(vector_a, vector_b) / (magnitude_of_vector(vector_a) * magnitude_of_vector(vector_b));
end