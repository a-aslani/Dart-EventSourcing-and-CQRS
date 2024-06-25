abstract class ICommandRepository<TEntity, TId> {
  Future<void> save(TEntity entity);
  Future<TEntity> load(TId id);
}