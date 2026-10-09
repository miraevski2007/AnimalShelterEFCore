using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace AnimalShelterEFCore.Models;

public partial class AnimalShelterContext : DbContext
{
    public AnimalShelterContext()
    {
    }

    public AnimalShelterContext(DbContextOptions<AnimalShelterContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AdoptionRequest> AdoptionRequests { get; set; }

    public virtual DbSet<Animal> Animals { get; set; }

    public virtual DbSet<Enclosure> Enclosures { get; set; }

    public virtual DbSet<Owner> Owners { get; set; }

    public virtual DbSet<Placement> Placements { get; set; }

    public virtual DbSet<TransferContract> TransferContracts { get; set; }

    public virtual DbSet<VeterinaryEvent> VeterinaryEvents { get; set; }

    public virtual DbSet<ViewAnimalCard> ViewAnimalCards { get; set; }

    public virtual DbSet<ViewArrivalAdoptionReport> ViewArrivalAdoptionReports { get; set; }

    public virtual DbSet<ViewAvailableAnimal> ViewAvailableAnimals { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=localhost;Database=AnimalShelterDB;Trusted_Connection=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AdoptionRequest>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__adoption__3213E83FD74B8F18");

            entity.ToTable("adoption_requests");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.AnimalId).HasColumnName("animal_id");
            entity.Property(e => e.InterviewResult)
                .HasMaxLength(255)
                .HasColumnName("interview_result");
            entity.Property(e => e.OwnerId).HasColumnName("owner_id");
            entity.Property(e => e.RequestDate).HasColumnName("request_date");
            entity.Property(e => e.Status)
                .HasMaxLength(30)
                .HasColumnName("status");

            entity.HasOne(d => d.Animal).WithMany(p => p.AdoptionRequests)
                .HasForeignKey(d => d.AnimalId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__adoption___anima__619B8048");

            entity.HasOne(d => d.Owner).WithMany(p => p.AdoptionRequests)
                .HasForeignKey(d => d.OwnerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__adoption___owner__60A75C0F");
        });

        modelBuilder.Entity<Animal>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__animals__3213E83F7A122237");

            entity.ToTable("animals");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.AgeYears)
                .HasColumnType("decimal(4, 1)")
                .HasColumnName("age_years");
            entity.Property(e => e.ArrivalDate).HasColumnName("arrival_date");
            entity.Property(e => e.ArrivalSource)
                .HasMaxLength(150)
                .HasColumnName("arrival_source");
            entity.Property(e => e.Breed)
                .HasMaxLength(100)
                .HasColumnName("breed");
            entity.Property(e => e.Color)
                .HasMaxLength(50)
                .HasColumnName("color");
            entity.Property(e => e.Gender)
                .HasMaxLength(10)
                .HasColumnName("gender");
            entity.Property(e => e.Nickname)
                .HasMaxLength(50)
                .HasColumnName("nickname");
            entity.Property(e => e.SpecialMarks)
                .HasMaxLength(255)
                .HasColumnName("special_marks");
            entity.Property(e => e.Species)
                .HasMaxLength(50)
                .HasColumnName("species");
            entity.Property(e => e.Status)
                .HasMaxLength(30)
                .HasColumnName("status");
        });

        modelBuilder.Entity<Enclosure>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__enclosur__3213E83F7E756F68");

            entity.ToTable("enclosures");

            entity.HasIndex(e => e.Number, "UQ__enclosur__FD291E416CC650C8").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Capacity).HasColumnName("capacity");
            entity.Property(e => e.Number)
                .HasMaxLength(20)
                .HasColumnName("number");
            entity.Property(e => e.Type)
                .HasMaxLength(50)
                .HasColumnName("type");
        });

        modelBuilder.Entity<Owner>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__owners__3213E83FF12F62B0");

            entity.ToTable("owners");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.Address)
                .HasMaxLength(255)
                .HasColumnName("address");
            entity.Property(e => e.FullName)
                .HasMaxLength(150)
                .HasColumnName("full_name");
            entity.Property(e => e.HasOtherAnimals).HasColumnName("has_other_animals");
            entity.Property(e => e.LivingConditions)
                .HasMaxLength(255)
                .HasColumnName("living_conditions");
            entity.Property(e => e.Phone)
                .HasMaxLength(30)
                .HasColumnName("phone");
        });

        modelBuilder.Entity<Placement>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__placemen__3213E83F306DB66A");

            entity.ToTable("placements");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.AnimalId).HasColumnName("animal_id");
            entity.Property(e => e.EnclosureId).HasColumnName("enclosure_id");
            entity.Property(e => e.PlacedAt).HasColumnName("placed_at");
            entity.Property(e => e.RemovedAt).HasColumnName("removed_at");

            entity.HasOne(d => d.Animal).WithMany(p => p.Placements)
                .HasForeignKey(d => d.AnimalId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__placement__anima__534D60F1");

            entity.HasOne(d => d.Enclosure).WithMany(p => p.Placements)
                .HasForeignKey(d => d.EnclosureId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__placement__enclo__5441852A");
        });

        modelBuilder.Entity<TransferContract>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__transfer__3213E83F1A7E315C");

            entity.ToTable("transfer_contracts");

            entity.HasIndex(e => e.RequestId, "UQ__transfer__18D3B90EA7E79447").IsUnique();

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.ContractDate).HasColumnName("contract_date");
            entity.Property(e => e.ControlVisitDate).HasColumnName("control_visit_date");
            entity.Property(e => e.RequestId).HasColumnName("request_id");
            entity.Property(e => e.VisitResult)
                .HasMaxLength(255)
                .HasColumnName("visit_result");

            entity.HasOne(d => d.Request).WithOne(p => p.TransferContract)
                .HasForeignKey<TransferContract>(d => d.RequestId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__transfer___reque__66603565");
        });

        modelBuilder.Entity<VeterinaryEvent>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__veterina__3213E83FD06A9F25");

            entity.ToTable("veterinary_events");

            entity.Property(e => e.Id).HasColumnName("id");
            entity.Property(e => e.AnimalId).HasColumnName("animal_id");
            entity.Property(e => e.Cost)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("cost");
            entity.Property(e => e.Description)
                .HasMaxLength(500)
                .HasColumnName("description");
            entity.Property(e => e.EventDate).HasColumnName("event_date");
            entity.Property(e => e.EventType)
                .HasMaxLength(50)
                .HasColumnName("event_type");
            entity.Property(e => e.Veterinarian)
                .HasMaxLength(100)
                .HasColumnName("veterinarian");

            entity.HasOne(d => d.Animal).WithMany(p => p.VeterinaryEvents)
                .HasForeignKey(d => d.AnimalId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__veterinar__anima__5812160E");
        });

        modelBuilder.Entity<ViewAnimalCard>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("View_AnimalCard");

            entity.Property(e => e.IdЖивотного).HasColumnName("ID Животного");
            entity.Property(e => e.Вид).HasMaxLength(50);
            entity.Property(e => e.ВидМероприятия)
                .HasMaxLength(50)
                .HasColumnName("Вид мероприятия");
            entity.Property(e => e.Возраст).HasColumnType("decimal(4, 1)");
            entity.Property(e => e.Вольер).HasMaxLength(20);
            entity.Property(e => e.Врач).HasMaxLength(100);
            entity.Property(e => e.ДатаВетмероприятия).HasColumnName("Дата ветмероприятия");
            entity.Property(e => e.ДатаВыбытияИзВольера).HasColumnName("Дата выбытия из вольера");
            entity.Property(e => e.ДатаЗаявки).HasColumnName("Дата заявки");
            entity.Property(e => e.ДатаПоступления).HasColumnName("Дата поступления");
            entity.Property(e => e.ДатаРазмещения).HasColumnName("Дата размещения");
            entity.Property(e => e.ИсточникПоступления)
                .HasMaxLength(150)
                .HasColumnName("Источник поступления");
            entity.Property(e => e.Кличка).HasMaxLength(50);
            entity.Property(e => e.Окрас).HasMaxLength(50);
            entity.Property(e => e.Описание).HasMaxLength(500);
            entity.Property(e => e.ОсобыеПриметы)
                .HasMaxLength(255)
                .HasColumnName("Особые приметы");
            entity.Property(e => e.Пол).HasMaxLength(10);
            entity.Property(e => e.Порода).HasMaxLength(100);
            entity.Property(e => e.РезультатСобеседования)
                .HasMaxLength(255)
                .HasColumnName("Результат собеседования");
            entity.Property(e => e.Статус).HasMaxLength(30);
            entity.Property(e => e.СтатусЗаявки)
                .HasMaxLength(30)
                .HasColumnName("Статус заявки");
            entity.Property(e => e.Стоимость).HasColumnType("decimal(10, 2)");
            entity.Property(e => e.ТипВольера)
                .HasMaxLength(50)
                .HasColumnName("Тип вольера");
        });

        modelBuilder.Entity<ViewArrivalAdoptionReport>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("View_ArrivalAdoptionReport");

            entity.Property(e => e.ПоступилоЖивотных).HasColumnName("Поступило животных");
            entity.Property(e => e.ПристроеноЖивотных).HasColumnName("Пристроено животных");
            entity.Property(e => e.СреднийСрокПребыванияДней)
                .HasColumnType("decimal(10, 1)")
                .HasColumnName("Средний срок пребывания, дней");
        });

        modelBuilder.Entity<ViewAvailableAnimal>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("View_AvailableAnimals");

            entity.Property(e => e.IdЖивотного).HasColumnName("ID Животного");
            entity.Property(e => e.Вид).HasMaxLength(50);
            entity.Property(e => e.ВозрастЛет)
                .HasColumnType("decimal(4, 1)")
                .HasColumnName("Возраст, лет");
            entity.Property(e => e.ДатаПоступления).HasColumnName("Дата поступления");
            entity.Property(e => e.Кличка).HasMaxLength(50);
            entity.Property(e => e.НомерВольера)
                .HasMaxLength(20)
                .HasColumnName("Номер вольера");
            entity.Property(e => e.Окрас).HasMaxLength(50);
            entity.Property(e => e.ОсобыеПриметы)
                .HasMaxLength(255)
                .HasColumnName("Особые приметы");
            entity.Property(e => e.Пол).HasMaxLength(10);
            entity.Property(e => e.Порода).HasMaxLength(100);
            entity.Property(e => e.СрокПребыванияДней).HasColumnName("Срок пребывания, дней");
            entity.Property(e => e.Статус).HasMaxLength(30);
            entity.Property(e => e.ТипВольера)
                .HasMaxLength(50)
                .HasColumnName("Тип вольера");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
