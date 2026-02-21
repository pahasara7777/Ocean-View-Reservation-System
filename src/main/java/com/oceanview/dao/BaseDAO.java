package com.oceanview.dao;

import java.util.List;
import java.util.Optional;

/**
 * Generic Base DAO interface providing standard CRUD operations.
 * * @param <T> The model entity type (e.g., Reservation, User)
 * @param <ID> The primary key type (e.g., Integer, String)
 */
public interface BaseDAO<T, ID> {
    
    /**
     * Saves a new entity to the database.
     * @param entity The object to save
     * @return true if successful, false otherwise
     */
    boolean save(T entity);

    /**
     * Retrieves an entity by its primary key.
     * Uses Optional to handle null returns gracefully.
     * * @param id The primary key
     * @return An Optional containing the entity if found
     */
    Optional<T> findById(ID id);

    /**
     * Retrieves all entities from the database.
     * @return A List of entities
     */
    List<T> findAll();

    /**
     * Updates an existing entity.
     * @param entity The object with updated values
     * @return true if successful, false otherwise
     */
    boolean update(T entity);

    /**
     * Deletes an entity by its primary key.
     * @param id The primary key
     * @return true if successful, false otherwise
     */
    boolean delete(ID id);
}