package KHUHEEDAE.KHUPLATE.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@Getter
@Table(name="REVIEW")
public class Review {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="REVIEW_ID")
    private Long id;

    @ManyToOne
    @JoinColumn(name="FOOD_ID")
    private Food food;

    @Column(name="REVIEW_CONTENT")
    private String content;

    @Column(name="REVIEW_RATE")
    private int rate;

    @Column(name="REVIEW_OWNER")
    private String reviewer;

    @Column(name="REVIEW_DATE")
    @CreationTimestamp
    private LocalDateTime date;

}
