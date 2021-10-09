package KHUHEEDAE.KHUPLATE.domain;

import javax.persistence.*;

@Entity
@Table(name="CATEGORY")
public class Category {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="CATEGORY_ID")
    private Long id;

    @Column(name="CATEOGRY_NAME")
    private String name;


}
