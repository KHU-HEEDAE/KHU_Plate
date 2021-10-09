package KHUHEEDAE.KHUPLATE.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;


@Entity
@Getter
@NoArgsConstructor
@Table(name="FOOD")
public class Food {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="FOOD_ID")
    private Long id;

    @Column(name="FOOD_NAME", nullable = false)
    private String name;

    @Column(name="FOOD_ADDRESS", nullable = false)
    private String address;

    @Column(name="FOOD_TEL", nullable = false)
    private String tel;

    @Column(name="FOOD_RATE", nullable = false)
    private int rate;

    @Column(name="FOOD_REVIEW_NUM", nullable = false)
    private int reviewNum;

    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name="CATEOGORY_ID")
    private Category category;

}
